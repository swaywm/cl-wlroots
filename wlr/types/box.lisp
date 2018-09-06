(in-package #:cl-wlroots/types/box)

(export '(box-closest-point
	  box-intersection
	  box-contains-point
	  box-empty-p
	  box-transform
	  box-rotated-bounds))

(defcfun ("wlr_box_closest_point" internal-box-closest-point) :void
  (box (:pointer box))
  (x :double)
  (y :double)
  (dest-x (:pointer :double))
  (dest-y (:pointer :double)))

(defun box-closest-point (box x y)
  "Returns the closest points as (values x y)"
  (cffi:with-foreign-objects ((dest-x :double)
			      (dest-y :double))
    (internal-box-closest-point box x y dest-y dest-y)
    (values (the double-float (mem-ref dest-x :double))
	    (the double-float (mem-ref dest-y :double)))))

(defcfun ("wlr_box_intersection" box-intersection) :bool
  (box-a (:pointer box))
  (box-b (:pointer box))
  (dest  (:pointer box)))

(defcfun ("wlr_box_contains_point" box-contains-point) :bool
  (box (:pointer box))
  (x :double)
  (y :double))

(defcfun ("wlr_box_empty" box-empty-p) :bool
  (box (:pointer box)))

(defcfun ("wlr_box_transform" box-transform) :void
  (transform wl-output-transform)
  (width :int)
  (height :int)
  (dest (:pointer box)))

(defcfun ("wlr_box_rotated_bounds" box-rotated-bounds) :void
  (box (:pointer box))
  (rotation :float)
  (dest (:pointer box)))
