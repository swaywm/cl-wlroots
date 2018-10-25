(in-package #:wlr/types/surface)

(export '(subsurface
	 subsurface-create
	 subsurface-state
	 surface
	 surface-create
	 surface-for-each-surface
	 surface-from-resource
	 surface-get-extends
	 surface-get-root-surface
	 surface-get-texture
	 surface-has-buffer
	 surface-point-accepts-input
	 surface-role
	 surface-send-enter
	 surface-send-frame-done
	 surface-send-leave
	 surface-set-role
	 surface-state
	 surface-state-field
	 surface-surface-at))

(cffi:defcfun ("wlr_surface_create" surface-create) :pointer
  (client :pointer)
  (version :uint32)
  (id :uint32)
  (renderer :pointer)
  (resource-list :pointer))

(cffi:defcfun ("wlr_surface_set_role" surface-set-role) :pointer
  (surface :pointer)
  (role :pointer)
  (role-data :pointer)
  (error-resource :pointer)
  (error-code :uint32))

(cffi:defcfun ("wlr_surface_has_buffer" surface-has-buffer) :pointer
  (surface :pointer))

(cffi:defcfun ("wlr_surface_get_texture" surface-get-texture) :pointer
  (surface :pointer))

(cffi:defcfun ("wlr_subsurface_create" subsurface-create) :pointer
  (surface :pointer)
  (parent :pointer)
  (version :uint32)
  (id :pointer)
  (resource-list :pointer))

(cffi:defcfun ("wlr_surface_get_root_surface" surface-get-root-surface) :pointer
  (surface :pointer))

(cffi:defcfun ("wlr_surface_point_accepts_input" surface-point-accepts-input) :pointer
  (surface :pointer)
  (sx :double)
  (sy :double))

(cffi:defcfun ("wlr_surface_surface_at" surface-surface-at) :pointer
  (surface :pointer)
  (sx :double)
  (sy :double)
  (sub-x :pointer)
  (sub-y :pointer))

(cffi:defcfun ("wlr_surface_send_enter" surface-send-enter) :void
  (surface :pointer)
  (output (:pointer (:struct output))))

(cffi:defcfun ("wlr_surface_send_leave" surface-send-leave) :void
  (surface :pointer)
  (output (:pointer (:struct output))))

(cffi:defcfun ("wlr_surface_send_frame_done" surface-send-frame-done) :void
  (surface :pointer)
  (time :pointer))

(cffi:defcfun ("wlr_surface_get_extends" surface-get-extends) :void
  (surface :pointer)
  (box box))

(cffi:defcfun ("wlr_surface_from_resource" surface-from-resource) :pointer
  (resource :pointer))

(cffi:defcfun ("wlr_surface_for_each_surface" surface-for-each-surface) :void
  (surface :pointer)
  (iterator :pointer)
  (user-data :pointer))
