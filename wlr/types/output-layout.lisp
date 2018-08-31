(in-package #:cl-wlroots/types/output-layout)

(export '(output_layout
	  direction
	  output_layout_output
	  output-layout-create
	  output-layout-destroy
	  output-layout-add-auto
	  output-layout-remove))

(defcfun ("wlr_output_layout_create" output-layout-create) (:pointer (:struct output_layout)))

(defcfun ("wlr_output_layout_destroy" output-layout-destroy) :void
  (output-layout (:pointer (:struct output_layout))))

(defcfun ("wlr_output_layout_add_auto" output-layout-add-auto) :void
  (layout (:pointer (:struct output_layout)))
  (output (:pointer (:struct output))))

(defcfun ("wlr_output_layout_remove" output-layout-remove) :void
  (layout (:pointer (:struct output_layout)))
  (output (:pointer (:struct output))))
