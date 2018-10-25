(in-package #:wlr/types/output-layout)

(export '(output-layout
	  direction
	  output-layout-output
	  layout-output
	  get-x
	  get-y
	  get-width
	  get-height
	  output-layout-create
	  output-layout-coords
	  output-layout-destroy
	  output-layout-add-auto
	  output-layout-remove
	  output-layout-get
	  output-layout-get-box
	  output-layout-get-center-output
	  output-layout-output-at
	  output-layout-move))

(cffi:define-foreign-type layout-output  ()
  ((wlr-output-layout-output :initarg :wlr-layout-output
			     :reader output-layout-wlr-output
			     :type cffi:foreign-pointer))
  (:actual-type :pointer)
  (:simple-parser layout-output))

(eval-when (:compile-toplevel)
  (define-accessor get-x (layout-output layout-output)
    (foreign-slot-value (output-layout-wlr-output layout-output)
			'(:struct output-layout-output) :x))

  (define-accessor get-y (layout-output layout-output)
    (foreign-slot-value (output-layout-wlr-output layout-output)
			'(:struct output-layout-output) :y))

  (defmethod translate-to-foreign (object (type layout-output))
    (output-layout-wlr-output object))

  (defmethod translate-from-foreign (object (type layout-output))
    (make-instance 'layout-output :wlr-layout-output object))

  ;; (defmethod print-object ((object layout-output) stream)
  ;; (print-unreadable-object (object stream :type t)
  ;;   (with-accessors ((x get-x)
  ;; 		     (y get-y))
  ;; 	object
  ;;     (format stream "(~A ~A)" x y))))
  )

(defcfun "wlr_output_layout_create" (:pointer (:struct output-layout)))

(wlr/base:def-initialization output-layout-create ()
  'output-layout wlr-output-layout-create)

(defcfun ("wlr_output_layout_destroy" output-layout-destroy) :void
  (output-layout (:pointer (:struct output-layout))))

(defcfun ("wlr_output_layout_add_auto" output-layout-add-auto) :void
  (layout (:pointer (:struct output-layout)))
  (output (:pointer (:struct output))))

(defcfun ("wlr_output_layout_get" output-layout-get) layout-output
  (layout (:pointer (:struct output-layout)))
  (reference (:pointer (:struct output))))

(defcfun ("wlr_output_layout_output_at" output-layout-output-at) (:pointer (:struct output))
  (layout (:pointer (:struct output-layout)))
  (lx :double)
  (ly :double))

(defcfun ("wlr_output_layout_add" output-layout-add) :void
  (layout (:pointer (:struct output-layout)))
  (output (:pointer (:struct output)))
  (lx :int)
  (ly :int))

(defcfun ("wlr_output_layout_move" output-layout-move) :void
  (layout (:pointer (:struct output-layout)))
  (output (:pointer (:struct output)))
  (lx :int)
  (ly :int))

(defcfun ("wlr_output_layout_remove" output-layout-remove) :void
  (layout (:pointer (:struct output-layout)))
  (output (:pointer (:struct output))))

(defcfun "wlr_output_layout_output_coords" :void
  (layout (:pointer (:struct output-layout)))
   (reference (:pointer (:struct output)))
   (lx (:pointer :double))
   (ly (:pointer :double)))

(defun output-layout-coords (layout reference)
  (with-foreign-objects ((lx :double) (ly :double))
    (wlr-output-layout-output-coords layout reference lx ly)
    (values (mem-ref lx :double) (mem-ref ly :double))))

(defcfun ("wlr_output_layout_get_box" output-layout-get-box) box
  "Get the box of the layout for the given reference output in layout
coordinates. If `reference` is NULL, the box will be for the extents of the
entire layout."
  (layout (:pointer (:struct output-layout)))
  (reference (:pointer (:struct output))))

(defcfun ("wlr_output_layout_get_center_output" output-layout-get-center-output) (:pointer (:struct output))
  (layout (:pointer (:struct output-layout))))
