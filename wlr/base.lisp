(in-package #:wlr/base)

(export '(initialization-error
	  def-initialization
	  with-return-pointer))

(define-foreign-library libwlroots
  (:unix (:or "libwlroots.so.0.0.1" "libwlroots.so.0" "libwlroots"))
  (t (:default "libwlroots")))

(use-foreign-library libwlroots)

(defun flatten-args (arg-list)
  (multiple-value-bind (required-args optional-args rest-name
				      keywords other-keys aux key-present)
      (alexandria:parse-ordinary-lambda-list arg-list)
    (declare (ignore keywords))
    (when (or rest-name key-present other-keys aux key-present)
      (error "&rest, &key &allow-other-keys, and &aux are not allowed in def-initialization functions"))
    (let ((flattened-args (reverse required-args)))
      (dolist (arg optional-args)
	(push (first arg) flattened-args)
	(when (null (second arg))
	  (error (format nil "Optional argument ~S must have a default value" (first arg)))))
      (reverse flattened-args))))

(defmacro def-initialization (func-name (&rest args) type creation-function &optional doc)
  "Create a function with function name FUNC-NAME and arguments ARGS. In the function, call
CREATION-FUNCTION and signal an error showing the wlr type TYPE if the result is a cffi:null-pointer.

Optional arguments are allowed, and passed to creation-function in the order that they appear. You
must specify a default value for these arguments. Other special argument types are not allowed."
  ;; lambda-lists with &optional parameters can't go directly into the function call
  ;; and need to be "flattened"
  (let ((flattened-args (flatten-args args)))
    `(defun ,func-name (,@args)
       ,doc
       (let ((new-thing (,creation-function ,@flattened-args)))
	 (when (cffi:null-pointer-p new-thing)
	   (error 'initialization-error :wlr-type ,type))
	 new-thing))))

(defmacro with-return-pointer ((dest-var type) &body body)
  "Allocates DEST-VAR as a foreign pointer. Once BODY has been executed,
the contents of DEST-VAR is translated as per TYPE and returned."
  `(with-foreign-object (,dest-var :pointer)
     ,@body
     (convert-from-foreign ,dest-var ,type)))
