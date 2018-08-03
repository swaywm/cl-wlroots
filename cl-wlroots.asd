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
	   :components ((:file "package")
			(:file "base" :depends-on ("package"))
			(:cffi-grovel-file "backend/session-grovel")
			(:file "backend/session")
			(:cffi-grovel-file "backend-grovel")
			(:file "backend")
			(:cffi-grovel-file "util/log-grovel")
			(:file "util/log")
			(:file "final")))))
