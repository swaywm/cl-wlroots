;;;; cl-wlroots.asd

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
