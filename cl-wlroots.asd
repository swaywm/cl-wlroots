;;;; cl-wlroots.asd

(asdf:defsystem #:cl-wlroots
  :description "Common lisp bindings for wlroots, a library for writing Wayland compositors"
  :author "Stuart Dilts stuart dot dilts at gmail dot com"
  :license  "MIT"
  :version "0.0.1"
  :defsystem-depends-on (#:cffi-grovel)
  :depends-on (#:cffi #:cffi-grovel #:cl-wayland #:cl-egl #:xkbcommon #:alexandria)
  :serial t
  :components
  ((:module wlr
	    ;; use the functions in gen-asd-file.lisp to generate the file list:
	    :components ((:FILE "package") (:FILE "error") (:FILE "base")
			 (:CFFI-GROVEL-FILE "common-grovel" :DEPENDS-ON ("package"))
			 (:FILE "common" :DEPENDS-ON ("common-grovel"))
			 (:FILE "config" :DEPENDS-ON ("common" "package"))
			 (:CFFI-GROVEL-FILE "config-grovel" :DEPENDS-ON ("config"))
			 (:CFFI-GROVEL-FILE "backend-grovel" :DEPENDS-ON
					    ("common" "package" "render/renderer" "backend/session"))
			 (:FILE "backend" :DEPENDS-ON ("backend-grovel"))
			 (:CFFI-GROVEL-FILE "backend/session-grovel" :DEPENDS-ON ("common" "package"))
			 (:FILE "backend/session" :DEPENDS-ON ("backend/session-grovel"))
			 (:CFFI-GROVEL-FILE "render/renderer-grovel" :DEPENDS-ON ("common" "package"))
			 (:FILE "render/renderer" :DEPENDS-ON ("render/renderer-grovel"))
			 (:FILE "backend/wayland" :DEPENDS-ON
				("common" "package" "types/output" "types/input-device"))
			 (:CFFI-GROVEL-FILE "types/box-grovel" :DEPENDS-ON ("common" "package"))
			 (:FILE "types/box" :DEPENDS-ON ("types/box-grovel"))
			 (:CFFI-GROVEL-FILE "types/cursor-grovel" :DEPENDS-ON
					    ("common" "package" "types/input-device" "types/box" "types/output-layout"
						      "types/output"))
			 (:FILE "types/cursor" :DEPENDS-ON ("types/cursor-grovel"))
			 (:CFFI-GROVEL-FILE "types/data-device-grovel" :DEPENDS-ON
					    ("common" "package"))
			 (:FILE "types/data-device" :DEPENDS-ON ("types/data-device-grovel"))
			 (:CFFI-GROVEL-FILE "types/input-device-grovel" :DEPENDS-ON
					    ("common" "package"))
			 (:FILE "types/input-device" :DEPENDS-ON ("types/input-device-grovel"))
			 (:CFFI-GROVEL-FILE "types/output-grovel" :DEPENDS-ON
					    ("common" "package" "backend"))
			 (:FILE "types/output" :DEPENDS-ON ("types/output-grovel"))
			 (:CFFI-GROVEL-FILE "types/output-damage-grovel" :DEPENDS-ON
					    ("common" "package" "types/output"))
			 (:FILE "types/output-damage" :DEPENDS-ON ("types/output-damage-grovel"))
			 (:CFFI-GROVEL-FILE "types/output-layout-grovel" :DEPENDS-ON
					    ("common" "package" "types/output"))
			 (:FILE "types/output-layout" :DEPENDS-ON ("types/output-layout-grovel"))
			 (:CFFI-GROVEL-FILE "types/seat-grovel" :DEPENDS-ON
					    ("common" "package" "types/data-device"))
			 (:FILE "types/seat" :DEPENDS-ON ("types/seat-grovel"))
			 (:CFFI-GROVEL-FILE "util/log-grovel" :DEPENDS-ON ("common" "package"))
			 (:FILE "util/log" :DEPENDS-ON ("util/log-grovel"))
			 (:CFFI-GROVEL-FILE "version-grovel" :DEPENDS-ON ("common" "package"))
			 (:FILE "version" :DEPENDS-ON ("version-grovel")) (:FILE "final")))))
