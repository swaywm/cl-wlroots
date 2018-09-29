(in-package #:wlr/error)

(export '(initialization-error))

(define-condition initialization-error (error)
  ((new-object-type :initarg :wlr-type :reader new-object-type
	 :type symbol
	 :documentation "The type of the object that could not be initialized"))
  (:default-initargs
   :type (error "You must specify a type"))
  (:report (lambda (condition stream)
	     (format stream "Initialization error: could not create wlroots type ~A" (new-object-type condition)))))
