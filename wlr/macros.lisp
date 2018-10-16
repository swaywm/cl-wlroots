(in-package #:wlr/macros)

(export '(with-wlr-accessors))

(defmacro with-wlr-accessors (vars ptr type &body body)
  "Similar to with-accessors, but for wlr structs.
(with-wlr-acessors (slot-entry*) ptr type forms*

slot-entry::= (variable slot-name &key pointer)"
  (let ((ptr-var (gensym "PTR")))
    `(let ((,ptr-var ,ptr))
       (symbol-macrolet
	   ,(loop :for var :in vars
	       :collect
		 (let ((var-name (first var))
		       (slot-name (second var))
		       (options (cddr var)))
		   `(,var-name ,(if (getf options :pointer)
				    `(cffi:foreign-slot-pointer
				     ,ptr-var ',type ',slot-name)
				    `(cffi:foreign-slot-value
				     ,ptr-var ',type ',slot-name)))))
	 ,@body))))
