(in-package #:wlr/base)

(export '(initialization-error
	  def-initialization))

(define-foreign-library libwlroots
  (:unix (:or "libwlroots.so.0.0.1" "libwlroots.so.0"))
  (t (:default "libwlroots")))

(use-foreign-library libwlroots)

(defun flatten-args (arg-list)
  (multiple-value-bind (required-args optional-args rest-name
				      keywords other-keys aux key-present)
      (alexandria:parse-ordinary-lambda-list arg-list)
    (declare (ignore keywords))
    (when (or rest-name key-present other-keys aux key-present)
      (error "&rest, &key &allow-other-keys, and &aux are not allowed in def-initialization functions"))
    (let ((flattened-args required-args))
      (dolist (arg optional-args)
	(push (first arg) flattened-args)
	(when (null (second arg))
	  (error (format nil "Optional argument ~S must have a default value" (first arg)))))
      (reverse flattened-args))))

(defmacro def-initialization (func-name (&rest args) type creation-function &optional doc)
  "Create a function with function name FUNC-NAME and arguements ARGS. In the function, call
creation-function and signal an error showing the wlr type TYPE if the result is a cffi:null-pointer.

Optional arguments are allowed, and passed to creation-function in the order that they appear. You
must specify a default value for these arguments."
  ;; lambda-lists with &optional parameters can't go directly into the function call
  ;; and need to be "flattened"
  (let ((flattened-args (flatten-args args)))
    `(defun ,func-name (,@args)
       ,doc
       (let ((new-thing (,creation-function ,@flattened-args)))
	 (when (cffi:null-pointer-p new-thing)
	   (error 'initialization-error :wlr-type ,type))
	 new-thing))))
