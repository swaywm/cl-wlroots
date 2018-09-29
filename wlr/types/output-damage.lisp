(in-package #:wlr/types/output-damage)

(export '(output-damage
	  output-damage-create
	  output-damage-destroy
	  output-damage-make-current
	  output-damage-swap-buffers))

(defcfun "wlr_output_damage_create"
    (:pointer (:struct output-damage))
  (output (:pointer (:struct output))))

(def-initialization output-damage-create (output)
  'output-damage wlr-output-damage-create)

(defcfun ("wlr_output_damage_destroy" output-damage-destroy)
    :void
  (ouput-damage (:pointer (:struct output-damage))))

(defcfun ("wlr_output_damage_make_current" output-damage-make-current)
    :bool
  (output-damage (:pointer (:struct output-damage)))
  ;; pointer is actually a pixman_region32_t
  (needs-swap :pointer))

(defcfun ("wlr_output_damage_swap_buffers" output-damage-swap-buffers)
    :bool
  (output-damage (:pointer (:struct output-damage)))
  ;; timespec
  (time :pointer)
  (damage :pointer))
