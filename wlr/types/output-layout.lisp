(in-package #:wlr/types/output-layout)

(export '(output-layout
	  direction
	  output_layout-output
	  output-layout-create
	  output-layout-destroy
	  output-layout-add-auto
	  output-layout-remove
	  output-layout-get
	  output-layout-get-box
	  output-layout-get-center-output
	  output-layout-output-at
	  output-layout-move))

(defcfun "wlr_output_layout_create" (:pointer (:struct output-layout)))

(wlr/base:def-initialization output-layout-create ()
  'output-layout wlr-output-layout-create)

(defcfun ("wlr_output_layout_destroy" output-layout-destroy) :void
  (output-layout (:pointer (:struct output-layout))))

(defcfun ("wlr_output_layout_add_auto" output-layout-add-auto) :void
  (layout (:pointer (:struct output-layout)))
  (output (:pointer (:struct output))))

(defcfun ("wlr_output_layout_get" output-layout-get) (:pointer (:struct output-layout-output))
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

(defcfun ("wlr_output_layout_get_box" output-layout-get-box) (:pointer (:struct box))
  "Get the box of the layout for the given reference output in layout
coordinates. If `reference` is NULL, the box will be for the extents of the
entire layout."
  (layout (:pointer (:struct output-layout)))
  (reference (:pointer (:struct output))))

(defcfun ("wlr_output_layout_get_center_output" output-layout-get-center-output) (:pointer (:struct output))
  (layout (:pointer (:struct output-layout))))
