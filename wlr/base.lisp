(in-package #:cl-wlroots/base)

(export '(initialization-error
	  def-initialization))

(define-foreign-library libwlroots
  (:unix (:or "libwlroots.so.0"))
  (t (:default "libwlroots")))

(use-foreign-library libwlroots)

(define-condition initialization-error (error)
  ((new-object-type :initarg :wlr-type :reader new-object-type
	 :type symbol
	 :documentation "The type of the object that could not be initialized"))
  (:default-initargs
   :type (error "You must specify a type"))
  (:report (lambda (condition stream)
	     (format stream "Initialization error: could not create wlroots type ~A" (new-object-type condition)))))

(defmacro def-initialization (func-name (&rest args) type creation-function &optional doc)
  `(defun ,func-name (,@args)
     ,doc
     (let ((new-thing (,creation-function ,@args)))
       (when (cffi:null-pointer-p new-thing)
	 (error 'initialization-error :wlr-type ,type))
       new-thing)))
