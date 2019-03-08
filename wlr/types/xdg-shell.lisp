(in-package #:wlr/types/xdg-shell)

(export '(xdg-client
	  xdg-popup
	  xdg-popup-get-anchor-point
	  xdg-popup-get-toplevel-coords
	  xdg-popup-grab
	  xdg-popup-unconstrain-from-box
	  xdg-positioner
	  xdg-positioner-get-geometry
	  xdg-shell
	  xdg-shell-create
	  xdg-shell-destroy
	  xdg-surface
	  xdg-surface-at
	  xdg-surface-configure
	  xdg-surface-configure
	  xdg-surface-for-each-popup
	  xdg-surface-for-each-surface
	  xdg-surface-from-popup-resource
	  xdg-surface-from-resource
	  xdg-surface-from-wlr-surface
	  xdg-surface-from-toplevel-resource
	  xdg-surface-get-geometry
	  xdg-surface-ping
	  xdg-toplevel
	  xdg-toplevel-set-activated
	  xdg-toplevel-set-fullscreen
	  xdg-toplevel-set-maximized
	  xdg-toplevel-set-resizing
	  xdg-toplevel-set-size))

(cffi:defcfun "wlr_xdg_shell_create" (:pointer (:struct xdg-shell))
  (display :pointer))

(def-initialization xdg-shell-create (display)
  'xdg-shell wlr-xdg-shell-create)

(cffi:defcfun ("wlr_xdg_shell_destroy" xdg-shell-destroy) :void
  (xdg-shell (:pointer (:struct xdg-shell))))

(cffi:defcfun ("wlr_xdg_surface_from_resource" xdg-surface-from-resource)
    (:pointer (:struct xdg-surface))
  (resource :pointer))

(cffi:defcfun ("wlr_xdg_surface_from_popup_resource" xdg-surface-from-popup-resource)
    (:pointer (:struct xdg-shell))
  (resource :pointer))

(cffi:defcfun ("wlr_xdg_surface_from_toplevel_resource" xdg-surface-from-toplevel-resource)
    (:pointer (:struct xdg-shell))
  (resource :pointer))

(cffi:defcfun ("wlr_xdg_positioner_get_geometry" xdg-positioner-get-geometry) (:struct box)
  (positioner (:pointer (:struct xdg-positioner))))

(cffi:defcfun ("wlr_xdg_surface_ping" xdg-surface-ping) :void
  (surface (:pointer (:struct xdg-surface))))

(cffi:defcfun ("wlr_xdg_toplevel_send_close" xdg-toplevel-send-close) :void
  (surface (:pointer (:struct xdg-surface))))

(cffi:defcfun ("wlr_xdg_toplevel_set_size" xdg-toplevel-set-size) :pointer
  (surface (:pointer (:struct xdg-surface)))
  (width :uint32)
  (height :uint32))

(cffi:defcfun ("wlr_xdg_toplevel_set_activated" xdg-toplevel-set-activated) :pointer
  (surface (:pointer (:struct xdg-surface)))
  (activated :bool))

(cffi:defcfun ("wlr_xdg_toplevel_set_maximized" xdg-toplevel-set-maximized) :pointer
  (surface (:pointer (:struct xdg-surface)))
  (maximized :bool))

(cffi:defcfun ("wlr_xdg_toplevel_set_fullscreen" xdg-toplevel-set-fullscreen) :pointer
  (surface (:pointer (:struct xdg-surface)))
  (fullscreen :bool))

(cffi:defcfun ("wlr_xdg_toplevel_set_resizing" xdg-toplevel-set-resizing) :pointer
  (surface (:pointer (:struct xdg-surface)))
  (resizing :bool))

(cffi:defcfun ("wlr_xdg_toplevel_set_tiled" xdg-toplevel-set-tiled) :pointer
  (surface (:pointer (:struct xdg-surface)))
  (tiled-edges :uint32))

(cffi:defcfun ("wlr_xdg_surface_send_close" xdg-surface-send-close) :void
  (surface (:pointer (:struct xdg-surface))))

(cffi:defcfun ("wlr_xdg_popup_destroy" xdg-popup-destroy) :void
  (surface (:pointer (:struct xdg-surface))))

(cffi:defcfun ("wlr_xdg_popup_get_anchor_point" xdg-popup-get-anchor-point) :void
  (popup :pointer)
  (toplevel-sx :pointer)
  (toplevel-sy :pointer))

(cffi:defcfun ("wlr_xdg_popup_get_toplevel_coords" xdg-popup-get-toplevel-coords) :void
  (popup :pointer)
  (popup-sx :int)
  (popup-sy :int)
  (toplevel-sx :pointer)
  (toplevel-sy :pointer))

(cffi:defcfun ("wlr_xdg_popup_unconstrain_from_box" xdg-popup-unconstrain-from-box) :void
  (popup :pointer)
  (toplevel-sx-box :pointer))

(cffi:defcfun ("wlr_positioner_invert_x" positioner-invert-x) :void
  (positioner :pointer))

(cffi:defcfun ("wlr_positioner_invert_y" positioner-invert-y) :void
  (positioner :pointer))

(cffi:defcfun wlr-xdg-surface-surface-at :pointer
  (surface (:pointer (:struct xdg-surface)))
  (sx :double)
  (sy :double)
  (sub-x :pointer)
  (sub-y :pointer))

(defun xdg-surface-at (surface sx sy)
  (cffi:with-foreign-objects ((sub-x :int)
			      (sub-y :int))
    (values (wlr-xdg-surface-surface-at surface sx sy sub-x sub-y)
	    (the fixnum (mem-aref sub-x :int))
	    (the fixnum (mem-aref sub-x :int)))))

(cffi:defcfun ("wlr_surface_is_xdg_surface" surface-is-xdg-surface) :bool
  (surface (:pointer (:struct xdg-surface))))

(cffi:defcfun ("wlr_xdg_surface_from_wlr_surface" xdg-surface-from-wlr-surface) :pointer
  (surface (:pointer (:struct xdg-surface))))

(cffi:defcfun ("wlr_xdg_surface_get_geometry" xdg-surface-get-geometry) :void
  (surface (:pointer (:struct xdg-surface)))
  (box :pointer))

(cffi:defcfun ("wlr_xdg_surface_for_each_surface" xdg-surface-for-each-surface) :void
  (surface (:pointer (:struct xdg-surface)))
  (iterator :pointer)
  (user-data :pointer))

(cffi:defcfun ("wlr_xdg_surface_schedule_configure" xdg-surface-schedule-configure) :pointer
  (surface (:pointer (:struct xdg-surface))))

(cffi:defcfun ("wlr_xdg_surface_for_each_popup" xdg-surface-for-each-popup) :void
  (surface (:pointer (:struct xdg-surface)))
  (iterator :pointer)
  (user-data :pointer))
