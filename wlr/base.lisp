(in-package #:wlr/base)

(export '(initialization-error
	  def-initialization))

(define-foreign-library libwlroots
  (:unix (:or "libwlroots.so.0.0.1" "libwlroots.so.0"))
  (t (:default "libwlroots")))

(use-foreign-library libwlroots)


(defmacro def-initialization (func-name (&rest args) type creation-function &optional doc)
  `(defun ,func-name (,@args)
     ,doc
     (let ((new-thing (,creation-function ,@args)))
       (when (cffi:null-pointer-p new-thing)
	 (error 'initialization-error :wlr-type ,type))
       new-thing)))
