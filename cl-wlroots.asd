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
;;  ("backend")
;;  ("util/log")
;;  ("types/wlr-output" :depends-on ("backend"))
;;  ("types/wlr-output-layout" :depends-on ("types/wlr-output"))
;;  "final")

(asdf:defsystem #:cl-wlroots
  :description "CL bindings for wlroots and wayland"
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
			 (:CFFI-GROVEL-FILE "backend-grovel" :DEPENDS-ON ("package"))
			 (:FILE "backend" :DEPENDS-ON ("backend-grovel"))
			 (:CFFI-GROVEL-FILE "util/log-grovel" :DEPENDS-ON ("package"))
			 (:FILE "util/log" :DEPENDS-ON ("util/log-grovel"))
			 (:CFFI-GROVEL-FILE "types/wlr-output-grovel" :DEPENDS-ON
					    ("package" "backend"))
			 (:FILE "types/wlr-output" :DEPENDS-ON ("types/wlr-output-grovel"))
			 (:CFFI-GROVEL-FILE "types/wlr-output-layout-grovel" :DEPENDS-ON
					    ("package" "types/wlr-output"))
			 (:FILE "types/wlr-output-layout" :DEPENDS-ON
				("types/wlr-output-layout-grovel"))
			 (:FILE "final")))))
