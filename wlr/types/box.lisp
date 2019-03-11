(in-package #:wlr/types/box)

(export '(box
	  box-x
	  box-y
	  box-width
	  box-height
	  box-closest-point
	  box-intersection
	  box-contains-point-p
	  box-empty-p
	  box-transform
	  box-rotated-bounds))

(eval-when (:compile-toplevel :load-toplevel)
  (cffi:define-foreign-type box ()
    ((x :initarg :x
	:accessor box-x
	:type fixnum)
     (y :initarg :y
	:accessor box-y
	:type fixnum)
     (width :initarg :width
	    :accessor box-width
	    :type fixnum)
     (height :initarg :height
	     :accessor box-height
	     :type fixnum))
    (:actual-type :pointer)
    (:simple-parser box))

  (defmethod translate-to-foreign (box (type box))
    (let ((new-box (foreign-alloc '(:struct box))))
      (with-foreign-slots ((x y width height) new-box (:struct box))
	(setf x (truncate (box-x box))
	      y (truncate (box-y box))
	      width (box-width box)
	      height (box-height box)))
      new-box))

  (defmethod free-translated-object (pointer (type box) param)
    (declare (ignore param))
    (foreign-free pointer))

  (defmethod expand-from-foreign (form (type box))
    `(with-foreign-slots ((x y width height) ,form (:struct box))
       (make-instance 'box
		      :x x
		      :y y
		      :width width
		      :height height)))

  (defmethod expand-to-foreign-dyn (value var body (type box))
    `(with-foreign-object (,var :pointer)
       ;; every var defined in this with-foreign-slots form won't be seen by body:
       (with-foreign-slots ((x y width height) ,var (:struct box))
	 (setf x (slot-value ,value 'x)
	       y (slot-value ,value 'y)
	       width (truncate (slot-value ,value 'width))
	       height (truncate (slot-value ,value 'height))))
       ,@body)))

(defmethod print-object ((box box) stream)
  (print-unreadable-object (box stream :type t :identity t)
    (with-accessors ((x box-x)
		     (y box-y)
		     (width box-width)
		     (height box-height))
	box
      (format stream "(~S ~S) w:~S h:~S" x y width height))))

(defcfun "wlr_box_closest_point" :void
  (box box)
  (x :double)
  (y :double)
  (dest-x (:pointer :double))
  (dest-y (:pointer :double)))

(defun box-closest-point (box x y)
  "Returns the closest points as (values x y)"
  (cffi:with-foreign-objects ((dest-x :double)
			      (dest-y :double))
    (wlr-box-closest-point box x y dest-x dest-y)
    (values (the double-float (mem-ref dest-x :double))
	    (the double-float (mem-ref dest-y :double)))))

(defcfun "wlr_box_intersection" :bool
  (box-a box)
  (box-b box)
  (dest (:pointer (:struct box))))

(defun box-intersection (box-a box-b)
  "Returns the box that is the intersection of the given boxes"
  (with-return-pointer (dest 'box)
    (wlr-box-intersection box-a box-b dest)))

(defun box-contains-point-p (box x y)
  (and (not (box-empty-p box))
       (and (>= x (box-x box))
	    (< x (box-x box))
	    (>= y (box-y box))
	    (< y (box-y box)))))

(defun box-empty-p (box)
  (declare (type box box))
  (or (<= (box-width box) 0) (<= (box-height 0))))

(defcfun "wlr_box_transform" :void
  (box box)
  (transform wl-output-transform)
  (width :int)
  (height :int)
  (dest (:pointer (:struct box))))

(defun box-transform (box transform width height)
  "Transforms a box inside a 'width' by 'height' box. Returns a new box."
  (with-return-pointer (dest 'box)
    (wlr-box-transform box transform width height dest)))

(defcfun "wlr_box_rotated_bounds" :void
  (box box)
  (rotation :float)
  (dest (:pointer (:struct box))))

(defun box-rotated-bounds (box rotation)
  "Creates the smallest box that contains the box rotated about its center"
  (with-return-pointer (dest 'box)
    (wlr-box-rotated-bounds box rotation dest)))
