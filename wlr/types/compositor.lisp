(in-package #:wlr/types/compositor)

(export '(subcompositor
	  compositor
	  compositor-create
	  subsurfacep
	  surface-from-wlr-surface))

(defcstruct subsurface)

(defcfun ("wlr_compositor_destroy" compositor-destroy) :void
  (compositor :pointer))

(defcfun "wlr_compositor_create" :pointer
  (display :pointer)
  (renderer (:pointer (:struct renderer))))

(def-initialization compositor-create (display renderer)
  'compositor wlr-compositor-create)

(defcfun ("wlr_surface_is_subsurface" subsurfacep) :bool
  (surface :pointer))

(defcfun ("wlr_subsurface_from_wlr_surface" surface-from-wlr-surface) (:pointer (:struct subsurface))
  (surface :pointer))
