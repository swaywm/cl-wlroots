(in-package :cl-user)

(defun build-deps (file-name &key (req-first :grovel) (depends-on ()) (has-grovel t))
  (let ((grovel-name (concatenate 'string file-name "-grovel"))
	(full-deps (cons "package" depends-on)))
    (when (not (string-equal file-name "common"))
      (push "common" full-deps))
    (if has-grovel
	(ecase req-first
	  (:grovel (list (list :cffi-grovel-file grovel-name :depends-on full-deps)
			 (list :file file-name :depends-on `(,grovel-name))))
	  (:file (list (list :file file-name :depends-on full-deps)
		       (list :cffi-grovel-file grovel-name :depends-on `(,file-name)))))
	(list (list :file file-name :depends-on full-deps)))))

(defun build-files (&rest files)
  (let ((entry-list ()))
    (dolist (entry (reverse files))
      (if (typep entry 'list)
	  (setf entry-list (nconc (apply #'build-deps entry) entry-list))
	  (setf entry-list (cons `(:file ,entry) entry-list))))
    entry-list))

;; build-files will generate a list sutaible for passing to asdf
;; a list argument will generate a :grovel-file call, while entries not
;; in a list will be passed as-is. If for some rare reason that
;; the grovel file needs to be loaded after the normal file,
;; specify :req-first :file
(build-files
 "package"
 "error"
 "base"
 '("common")
 '("config" :req-first :file)
 ;; this depends on a lot of stuff, not all implemented:
 '("backend" :depends-on ("render/renderer" "backend/session"))
 '("backend/session")
 '("render/renderer")
 '("backend/wayland" :has-grovel nil :depends-on ("types/output" "types/input-device"))
 '("types/box")
 '("types/cursor" :depends-on ("types/input-device" "types/box"
			       "types/output-layout" "types/output"))
 '("types/data-device")
 '("types/input-device")
 '("types/output" :depends-on ("backend"))
 '("types/output-damage" :depends-on ("types/output"))
 '("types/output-layout" :depends-on ("types/output"))
 '("types/seat" :depends-on ("types/data-device"))
 '("types/xcursor-manager" :depends-on ("types/cursor" "xcursor"))
 '("util/edges")
 '("util/log")
 '("version")
 '("xcursor" :depends-on ("util/edges"))
 "final")
