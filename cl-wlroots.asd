;;;; cl-wlroots.asd

(asdf:defsystem #:cl-wlroots
  :description "Common lisp bindings for wlroots, a library for writing Wayland compositors"
  :author "Stuart Dilts stuart dot dilts at gmail dot com"
  :license  "MIT"
  :version "0.0.1"
  :defsystem-depends-on (#:cffi-grovel #:wayland-scanner)
  :depends-on (#:cffi #:cffi-libffi #:cffi-grovel #:cl-wayland #:cl-egl #:xkbcommon #:alexandria)
  :components
  ((:module wayland-headers
	    :components
	    ((:c-wl-scanner "xdg-shell-protocol.h" :protocol-type :server
			    :protocol-name "xdg-shell")))
   (:module wayland-protocols
	    :components
	    ((:wl-scanner "xdg-shell-protocol" :protocol-type :server
			  :protocol-name "xdg-shell")
	     (:wl-scanner "wayland-sever-protocol" :protocol-type :server
			  :protocol-name "wayland"
			  :protocol-path #p"/usr/share/wayland/")))
   (:module wlr
	    :depends-on (wayland-headers wayland-protocols)
	    ;; use the functions in gen-asd-file.lisp to generate the file list:
	    :components
	    ((:FILE "package") (:FILE "error") (:FILE "base")
	     (:CFFI-GROVEL-FILE "common-c-types-grovel" :DEPENDS-ON ("package"))
	     (:FILE "common-c-types" :DEPENDS-ON ("common-c-types-grovel"))
	     (:FILE "config" :DEPENDS-ON ("common-c-types" "package"))
	     (:CFFI-GROVEL-FILE "config-grovel" :DEPENDS-ON ("config"))
	     (:CFFI-GROVEL-FILE "backend-grovel" :DEPENDS-ON
				("common-c-types" "package" "render/renderer" "backend/session"))
	     (:FILE "backend" :DEPENDS-ON ("backend-grovel"))
	     (:CFFI-GROVEL-FILE "backend/session-grovel" :DEPENDS-ON
				("common-c-types" "package"))
	     (:FILE "backend/session" :DEPENDS-ON ("backend/session-grovel"))
	     (:CFFI-GROVEL-FILE "render/renderer-grovel" :DEPENDS-ON
				("common-c-types" "package" "types/box"))
	     (:FILE "render/renderer" :DEPENDS-ON ("render/renderer-grovel"))
	     (:FILE "backend/wayland" :DEPENDS-ON
		    ("common-c-types" "package" "types/output" "types/input-device"))
	     (:CFFI-GROVEL-FILE "types/box-grovel" :DEPENDS-ON ("common-c-types" "package"))
	     (:FILE "types/box" :DEPENDS-ON ("types/box-grovel"))
	     (:CFFI-GROVEL-FILE "types/compositor-grovel" :DEPENDS-ON
				("common-c-types" "package" "render/renderer"))
	     (:FILE "types/compositor" :DEPENDS-ON ("types/compositor-grovel"))
	     (:CFFI-GROVEL-FILE "types/cursor-grovel" :DEPENDS-ON
				("common-c-types" "package" "types/input-device" "types/box" "types/output-layout"
					  "types/output"))
	     (:FILE "types/cursor" :DEPENDS-ON ("types/cursor-grovel"))
	     (:CFFI-GROVEL-FILE "types/data-device-grovel" :DEPENDS-ON
				("common-c-types" "package"))
	     (:FILE "types/data-device" :DEPENDS-ON ("types/data-device-grovel"))
	     (:CFFI-GROVEL-FILE "types/input-device-grovel" :DEPENDS-ON
				("common-c-types" "package"))
	     (:FILE "types/input-device" :DEPENDS-ON ("types/input-device-grovel"))
	     (:CFFI-GROVEL-FILE "types/output-grovel" :DEPENDS-ON
				("common-c-types" "package" "backend"))
	     (:FILE "types/output" :DEPENDS-ON ("types/output-grovel"))
	     (:FILE "types/matrix" :DEPENDS-ON ("common-c-types" "package" "types/box"))
	     (:CFFI-GROVEL-FILE "types/output-damage-grovel" :DEPENDS-ON
				("common-c-types" "package" "types/output"))
	     (:FILE "types/output-damage" :DEPENDS-ON ("types/output-damage-grovel"))
	     (:CFFI-GROVEL-FILE "types/output-layout-grovel" :DEPENDS-ON
				("common-c-types" "package" "types/output"))
	     (:FILE "types/output-layout" :DEPENDS-ON ("types/output-layout-grovel"))
	     (:CFFI-GROVEL-FILE "types/seat-grovel" :DEPENDS-ON
				("common-c-types" "package" "types/data-device" "types/surface"))
	     (:FILE "types/seat" :DEPENDS-ON ("types/seat-grovel"))
	     (:CFFI-GROVEL-FILE "types/xcursor-manager-grovel" :DEPENDS-ON
				("common-c-types" "package" "types/cursor" "xcursor"))
	     (:CFFI-GROVEL-FILE "types/surface-grovel" :DEPENDS-ON ("types/output" "types/box"))
	     (:FILE "types/surface" :DEPENDS-ON ("types/surface-grovel"))
	     (:FILE "types/xcursor-manager" :DEPENDS-ON
		    ("types/xcursor-manager-grovel"))
	     (:CFFI-GROVEL-FILE "types/xdg-shell-grovel" :DEPENDS-ON
				("common-c-types" "package" "types/box" "types/seat")
				:cc-flags #.(concatenate 'string
							 "-I"
							 (directory-namestring *load-pathname*)
							 "wayland-headers/"))
	     (:FILE "types/xdg-shell" :DEPENDS-ON ("types/xdg-shell-grovel"))
	     (:CFFI-GROVEL-FILE "util/edges-grovel" :DEPENDS-ON ("common-c-types" "package"))
	     (:FILE "util/edges" :DEPENDS-ON ("util/edges-grovel"))
	     (:CFFI-GROVEL-FILE "util/log-grovel" :DEPENDS-ON ("common-c-types" "package"))
	     (:FILE "util/log" :DEPENDS-ON ("util/log-grovel"))
	     (:CFFI-GROVEL-FILE "version-grovel" :DEPENDS-ON ("common-c-types" "package"))
	     (:FILE "version" :DEPENDS-ON ("version-grovel"))
	     (:CFFI-GROVEL-FILE "xcursor-grovel" :DEPENDS-ON
				("common-c-types" "package" "util/edges"))
	     (:FILE "xcursor" :DEPENDS-ON ("xcursor-grovel")) (:FILE "final")
	     (:FILE "macros")))))
