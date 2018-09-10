(ql:quickload "cl-wlroots")
;; (ql:quickload "swank")
;; (swank-loader:init)
;; (swank:create-server :port 4000
;; 		     :dont-close t)


(defpackage #:cl-wlr-test
  (:use #:cl #:wlr #:cffi #:wayland-server-core))

(in-package #:cl-wlr-test)

(defclass test-server ()
  ((display :initarg :display
	    :accessor display)
   (backend :initarg :backend
	    :accessor backend)
   (event-loop :initarg :event-loop
	       :accessor event-loop)
   (output-listener :initarg :output-listener
		    :accessor output-listener)
   (outputs :accessor outputs :initform ())))

(defvar *server* nil)

(defcallback server-handle-new-output
    :void ((listener (:pointer (:struct wl_listener))) (data :pointer))
  (declare (ignore listener data))
  (print "New output detected"))

(defun make-server ()
  (let* ((display (wl-display-create))
	 (event-loop (wl-display-get-event-loop display))
	 (backend (backend-autocreate display
				      (null-pointer)))
	 (listener (foreign-alloc '(:struct wl_listener))))
    ;; (with-foreign-slots ((notify notify) listener (:struct wl_listener))
    (setf (foreign-slot-value listener '(:STRUCT WL_LISTENER) 'notify) (callback server-handle-new-output))
    (wl-signal-add (foreign-slot-pointer backend  '(:struct wlr_backend) :event-new-input) listener)
    (make-instance 'test-server
		   :display display
		   :backend backend
		   :event-loop event-loop
		   :output-listener  listener)))

(defun destroy-server (server)
  (with-accessors ((display display) (backend backend)
		   (event-loop event-loop))
      server
    (backend-destroy backend)
    ;; (wl-event-loop-destroy event-loop)
    (wl-display-destroy display)))

(defun main ()
  (log-init :log-debug (cffi:null-pointer))
  (setf *server* (make-server))
  (unless (backend-start (backend *server*))
    (format t "Could not start backend")
    (wl-display-destroy (display *server*))
    (uiop:quit 1))
  (wl-display-run (display *server*))
  (wl-display-destroy (display *server*))
  (uiop:quit))

 (main)
