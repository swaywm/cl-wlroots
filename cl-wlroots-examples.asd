(asdf:defsystem #:cl-wlroots-examples
  :author "Stuart Dilts stuart dot dilts at gmail dot com"
  :license  "MIT"
  :version "0.0.1"
  :depends-on (#:cl-wlroots)
  :components ((:module "examples/"
			:components
			((:file "simple")))))
