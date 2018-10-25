(in-package #:wlr/types/output)

(export '(output-mode
	  output
	  output-cursor
	  output-effective-resolution
	  output-enable
	  output-make-current
	  output-swap-buffers
	  output-create-global
	  output-set-mode
	  output-transform-invert))

(defcfun ("wlr_output_enable" output-enable) :void
  (output (:pointer (:struct output)))
  (enable :bool))

(defcfun "wlr_output_effective_resolution" :void
  (output (:pointer (:struct output)))
  (width (:pointer :int))
  (height (:pointer :int)))

(defun output-effective-resolution (output)
  (with-foreign-objects ((width :int) (height :int))
    (wlr-output-effective-resolution output width height)
    (values width height)))

(defcfun ("wlr_output_make_current" output-make-current) :bool
  (output (:pointer (:struct output)))
  (buffer-age (:pointer :int)))

(defcfun ("wlr_output_swap_buffers" output-swap-buffers) :bool
  (output (:pointer (:struct output)))
  (time :pointer)
  (damage :pointer))

(defcfun ("wlr_output_create_global" output-create-global) :void
  (output (:pointer (:struct output))))

(defcfun ("wlr_output_set_mode" output-set-mode) :bool
  (output (:pointer (:struct output)))
  (mode (:pointer (:struct output-mode))))

(defcfun ("wlr_output_transform_invert" output-transform-invert) wayland-protocol:wl-output-transform
  (transform wayland-protocol:wl-output-transform))
