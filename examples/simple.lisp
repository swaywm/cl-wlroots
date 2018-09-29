(defpackage #:wlr-test/simple
  (:use :cl :wayland-server-core :cffi)
  (:import-from :xkb
		:with-keymap-from-names
		:with-xkb-context))

(in-package :wlr-test/simple)

(export '(run-simple))

;; helper functions:

;; there isn't a great way to associate listeners with
;; their owners. The best way seems to be storing the pairings
;; in a hash table:
(defvar *listener-hash* (make-hash-table))

(defun get-listener-owner (listener table)
  (gethash (cffi:pointer-address listener) table))

(defun register-listener (listener owner table)
  (setf (gethash (cffi:pointer-address listener) table) owner))

(defun unregister-listener (listener table)
  (remhash (cffi:pointer-address  listener) table))

(defmacro make-listener (callback)
  `(let ((listener (cffi:foreign-alloc '(:struct wl_listener))))
     (setf (cffi:foreign-slot-value listener '(:struct wl_listener) 'notify) (cffi:callback ,callback))
     listener))

;; simple implementation

(defstruct sample-state
  display
  backend)

(defstruct sample-output
  state
  output
  frame-listener
  destroy-listener)

(defstruct sample-keyboard
  state
  device
  key-listener
  destroy-listener)

(defvar *sample-state* nil)

(cffi:defcallback keyboard-key-notify :void
    ((listener :pointer)
     (event (:pointer (:struct wlr:event-keyboard-key))))
  (let* ((sample-keyboard (get-listener-owner listener *listener-hash*))
	 (wlr-keyboard (cffi:foreign-slot-value (sample-keyboard-device sample-keyboard)
						'(:struct wlr:input-device)
    						:keyboard))
	 (keycode (+ 8 (foreign-slot-value event '(:struct wlr:event-keyboard-key) :keycode))))
    (with-foreign-object (syms :pointer)
      (let ((num-syms (xkb:state-key-get-syms (foreign-slot-value wlr-keyboard
								    '(:struct wlr:keyboard)
								    :xkb-state)
					      keycode syms)))
	(format t "Num keysyms: ~A~%" num-syms)
	(dotimes (i num-syms)
	  ;; ref twice, as syms is a pointer to a pointer:
	  (let ((keysym (mem-aref (mem-ref syms :pointer) 'xkb:keysym i)))
	    (format t "Keysym: ~A~%" keysym)
	    (when (eql keysym #xff1b)
	      (wl-display-terminate (sample-state-display *sample-state*)))))
	  (finish-output)))))

(cffi:defcallback keyboard-destroy-notify :void
    ((listener :pointer)
     (keyboard (:pointer (:struct wlr:input-device))))
  (declare (ignore listener keyboard))
  (format t "A keyboard was destroyed~%"))

(defun setup-rules (rules)
  (setf (cffi:foreign-slot-value rules '(:struct xkb:rule-names)
				 :rules)
	(or (uiop:getenv "XKB_DEFAULT_RULES") ""))
  (setf (cffi:foreign-slot-value rules '(:struct xkb:rule-names)
				 :model)
	(or (uiop:getenv "XKB_DEFAULT_MODEL") ""))
  (setf (cffi:foreign-slot-value rules '(:struct xkb:rule-names)
				 :layout)
	(or (uiop:getenv "XKB_DEFAULT_LAYOUT") ""))
  (setf (cffi:foreign-slot-value rules '(:struct xkb:rule-names)
				 :variant)
	(or (uiop:getenv "XKB_DEFAULT_VARIANT") ""))
  (setf (cffi:foreign-slot-value rules '(:struct xkb:rule-names)
				 :options)
	(or (uiop:getenv "XKB_DEFAULT_OPTIONS") "")))

(defun add-new-keyboard (device)
  (format t "Keyboard added~%")
  (let* ((key-listener (make-listener keyboard-key-notify))
	 (destroy-listener (make-listener keyboard-destroy-notify))
	 (sample-keyboard (make-sample-keyboard :device device
						:state *sample-state*
						:key-listener key-listener
						:destroy-listener destroy-listener))
	 (wlr-keyboard (cffi:foreign-slot-value device '(:struct wlr:input-device)
    								    :keyboard)))

    (wl-signal-add (cffi:foreign-slot-pointer device '(:struct wlr:input-device)
					      :event-destroy)
		   destroy-listener)
    (wl-signal-add (foreign-slot-pointer wlr-keyboard
					 '(:struct wlr:keyboard) :event-key)
    		   key-listener)
    (with-foreign-object (rules '(:struct xkb:rule-names))
      (setup-rules rules)
      (with-xkb-context (context (:no-flags))
	(with-keymap-from-names (keymap (context rules :no-flags))
	  (wlr:keyboard-set-keymap wlr-keyboard keymap))))
    (register-listener key-listener sample-keyboard *listener-hash*)
    (register-listener destroy-listener sample-keyboard *listener-hash*)))

(cffi:defcallback new-input-notify :void
    ((listener :pointer)
     (input (:pointer (:struct wlr:input-device))))
  (declare (ignore listener))
  (format t "new input device ~A~%" (cffi:foreign-slot-value input
							  '(:struct wlr:input-device) :type))
  (case (cffi:foreign-slot-value input
  				  '(:struct wlr:input-device) :type)
    (:keyboard (add-new-keyboard input))
    (t (format t "Something that isn't a keyboard was added~%"))))


(cffi:defcallback new-frame-notify :void
    ((listener :pointer)
     (output :pointer))
  (declare (ignore output))
  ;; to be clear, the output passed into the function is the same as the one looked up here:
  (let* ((output-owner (get-listener-owner listener *listener-hash*))
	 (renderer (wlr:backend-get-renderer (foreign-slot-value (sample-output-output output-owner)
						       '(:struct wlr:output)
						       :backend))))
    (wlr:output-make-current (sample-output-output output-owner) (cffi:null-pointer))

    ;; renderer-clear takes care of array conversion for us:
    (wlr:renderer-clear renderer #(0.4 0.4 0.4 1.0))
    (wlr:output-swap-buffers (sample-output-output output-owner) (cffi:null-pointer)
			     (cffi:null-pointer))
    (wlr:renderer-end renderer)))

(cffi:defcallback destroy-output :void
    ((listener :pointer)
     (output :pointer))
  (format t "Output ~A removed~%" (foreign-string-to-lisp
				 (foreign-slot-pointer output '(:struct wlr:output)
  						       :name)))
  (finish-output)
  (let ((owner-listener (get-listener-owner listener *listener-hash*)))
    (unregister-listener listener *listener-hash*)
    (unregister-listener (sample-output-frame-listener owner-listener) *listener-hash*)
    (wl-list-remove (cffi:foreign-slot-pointer listener
    					       '(:struct wl_listener) 'wayland-server-core:link))
    (wl-list-remove (cffi:foreign-slot-pointer (sample-output-frame-listener owner-listener)
					       '(:struct wl_listener) 'wayland-server-core:link))
    (cffi:foreign-free listener)
    (cffi:foreign-free (sample-output-frame-listener owner-listener))))


(cffi:defcallback handle-new-output :void
    ((listener :pointer)
     (output (:pointer (:struct wlr:output))))
  (declare (ignore listener))
  (let ((frame-listener (make-listener new-frame-notify))
	(destroy-listener (make-listener destroy-output)))

    (format t "New output ~A~%" (foreign-string-to-lisp
				 (foreign-slot-pointer output '(:struct wlr:output)
  						       :name)))
    (finish-output)
    (wl-signal-add (cffi:foreign-slot-pointer output
    					      '(:struct wlr:output)
    					      :event-frame)
    		   frame-listener)
    (wl-signal-add (cffi:foreign-slot-pointer output
    					      '(:struct wlr:output)
    					      :event-destroy)
    		   destroy-listener)
    (let ((new-output (make-sample-output :state *sample-state*
    					  :output output
    					  :frame-listener frame-listener
    					  :destroy-listener destroy-listener)))
      (register-listener destroy-listener new-output *listener-hash*)
      (register-listener frame-listener new-output *listener-hash*))))

(defun run-simple ()
  (cl-wlroots/util/log:log-init :log-debug (cffi:null-pointer))
  (let* ((display (wl-display-create))
	 (backend (wlr:backend-autocreate display (cffi:null-pointer)))
	 (renderer (wlr:backend-get-renderer backend))
	 (new-output-listener (make-listener handle-new-output))
	 (new-input-listener (make-listener new-input-notify)))
    (assert (not (cffi:null-pointer-p renderer)))
    (wlr:renderer-init-wl-display renderer display)

    (wl-signal-add (cffi:foreign-slot-pointer backend
					      '(:struct wlr:backend)
					      :event-new-input)
		   new-input-listener)
    (wl-signal-add (cffi:foreign-slot-pointer backend
					      '(:struct wlr:backend)
					      :event-new-output)
		   new-output-listener)
    (setf *sample-state* (make-sample-state :display display
					    :backend backend))
    (unless (wlr:backend-start backend)
      (format t "Failed to start backend")
      (wlr:backend-destroy backend)
      (uiop:quit 1))
    (wl-display-run display)
    (wlr:backend-destroy backend)
    (wl-display-destroy display)))
