(in-package #:cl-wlroots/wlr-version)

(export '(+wlr-version-str+
	  +wlr-version-major+
	  +wlr-version-minor+
	  +wlr-version-micro+
	  +wlr-version-num+
	  +wlr-version-api-current+
	  +wlr-version-api-revision+
	  +wlr-version-api-age+))

(define-constant +wlr-version-str+ (format nil "~A.~A.~A" +wlr-version-major+ +wlr-version-minor+
					     +wlr-version-micro+)
  :test #'string-equal
  :documentation "The version of wlroots that is being used as a string")
