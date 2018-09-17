(in-package #:cl-wlroots/types/output)

(export '(output_mode
	  output
	  output-cursor
	  output-enable
	  output-make-current
	  output-swap-buffers
	  output-create-global
	  output-set-mode))

(defcfun ("wlr_output_enable" output-enable) :void
  (output (:pointer (:struct output)))
  (enable :bool))

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
  (mode (:pointer (:struct output_mode))))
