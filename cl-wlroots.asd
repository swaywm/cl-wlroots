;;;; cl-wlroots.asd
(in-package :cl-user)

(defun build-deps (file-name &key (req-first :grovel) (depends-on ()))
  (let ((grovel-name (concatenate 'string file-name "-grovel"))
	(full-deps (cons "package" depends-on)))
    (ecase req-first
	     (:grovel (list (list :cffi-grovel-file grovel-name :depends-on full-deps)
			    (list :file file-name :depends-on `(,grovel-name))))
	     (:file (list (list :file file-name :depends-on full-deps)
			  (list :cffi-grovel-file grovel-name :depends-on `(,file-name)))))))

(defmacro build-files (&rest files)
  (let ((entry-list ()))
    (dolist (entry (reverse files))
      (if (typep entry 'list)
	  (setf entry-list (nconc (apply #'build-deps entry) entry-list))
	  (setf entry-list (cons `(:file ,entry) entry-list))))
    entry-list))

;; (build-files
;;  "package"
;;  "base"
;;  ("backend/session")
;;  ("backend" :depends-on ("render/renderer"))
;;  ("util/log")
;;  ("types/output" :depends-on ("backend"))
;;  ("types/output-layout" :depends-on ("types/output"))
;;  ;; this depends on a lot of stuff, not all implemented:
;;  ("types/seat" :depends-on ("types/data-device"))
;;  ("types/data-device")
;;  ("types/output-damage" :depends-on ("types/output"))
;;  ("render/renderer")
;;  "final")

(asdf:defsystem #:cl-wlroots
  :description "CL bindings for wlroots"
  :author "Stuart Dilts stuart.dilts@gmail.com>"
  :license  "MIT"
  :version "0.0.1"
  :defsystem-depends-on (#:cffi-grovel)
  :depends-on (#:cffi #:cffi-grovel #:net.didierverna.declt
		      #:cl-wayland)
  :serial t
  :components
  ((:module wlr
	    :components ((:FILE "package") (:FILE "base")
			 (:CFFI-GROVEL-FILE "backend/session-grovel" :DEPENDS-ON ("package"))
			 (:FILE "backend/session" :DEPENDS-ON ("backend/session-grovel"))
			 (:CFFI-GROVEL-FILE "backend-grovel" :DEPENDS-ON ("package" "render/renderer"))
			 (:FILE "backend" :DEPENDS-ON ("backend-grovel"))
			 (:CFFI-GROVEL-FILE "util/log-grovel" :DEPENDS-ON ("package"))
			 (:FILE "util/log" :DEPENDS-ON ("util/log-grovel"))
			 (:CFFI-GROVEL-FILE "types/output-grovel" :DEPENDS-ON ("package" "backend"))
			 (:FILE "types/output" :DEPENDS-ON ("types/output-grovel"))
			 (:CFFI-GROVEL-FILE "types/output-layout-grovel" :DEPENDS-ON
					    ("package" "types/output"))
			 (:FILE "types/output-layout" :DEPENDS-ON ("types/output-layout-grovel"))
			 (:CFFI-GROVEL-FILE "types/seat-grovel" :DEPENDS-ON
					    ("package" "types/data-device"))
			 (:FILE "types/seat" :DEPENDS-ON ("types/seat-grovel"))
			 (:CFFI-GROVEL-FILE "types/data-device-grovel" :DEPENDS-ON ("package"))
			 (:FILE "types/data-device" :DEPENDS-ON ("types/data-device-grovel"))
			 (:CFFI-GROVEL-FILE "types/output-damage-grovel" :DEPENDS-ON
					    ("package" "types/output"))
			 (:FILE "types/output-damage" :DEPENDS-ON ("types/output-damage-grovel"))
			 (:CFFI-GROVEL-FILE "render/renderer-grovel" :DEPENDS-ON ("package"))
			 (:FILE "render/renderer" :DEPENDS-ON ("render/renderer-grovel"))
			 (:FILE "final")))))
