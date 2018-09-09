(in-package :cl-user)

(defun build-deps (file-name &key (req-first :grovel) (depends-on ()))
  (let ((grovel-name (concatenate 'string file-name "-grovel"))
	(full-deps (cons "package" depends-on)))
    (ecase req-first
	     (:grovel (list (list :cffi-grovel-file grovel-name :depends-on full-deps)
			    (list :file file-name :depends-on `(,grovel-name))))
	     (:file (list (list :file file-name :depends-on full-deps)
			  (list :cffi-grovel-file grovel-name :depends-on `(,file-name)))))))

(defun build-files (&rest files)
  (let ((entry-list ()))
    (dolist (entry (reverse files))
      (if (typep entry 'list)
	  (setf entry-list (nconc (apply #'build-deps entry) entry-list))
	  (setf entry-list (cons `(:file ,entry) entry-list))))
    entry-list))

(build-files
 "package"
 "base"
 '("common")
 '("backend" :depends-on ("render/renderer" "backend/session"))
 '("backend/session")
 '("render/renderer")
 '("types/box")
 '("types/data-device")
 '("types/output" :depends-on ("backend"))
 '("types/output-damage" :depends-on ("types/output"))
 '("types/output-layout" :depends-on ("types/output"))
  ;; this depends on a lot of stuff, not all implemented:
 '("types/seat" :depends-on ("types/data-device"))
 '("util/log")
 "final")
