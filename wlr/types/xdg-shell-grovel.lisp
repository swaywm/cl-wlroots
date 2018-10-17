(in-package #:wlr/types/xdg-shell)
(include "wlr/types/wlr_xdg_shell.h")
(pkg-config-cflags "wlroots")
(cc-flags "-DWLR_USE_UNSTABLE")


(cstruct xdg-shell "struct wlr_xdg_shell"
	 (:global "global" :type :pointer)
	 (:clients "clients" :type (:struct wl_list))
	 (:popup-grabs "popup_grabs" :type (:struct wl_list))
	 (:ping-timeout "ping_timeout" :type :uint32)
	 (:display-destroy "display_destroy" :type wl_listener)
	 (:event-new-surface "events.new_surface" :type (:struct wl_signal))
	 (:event-destroy "events.destroy" :type (:struct wl_signal)))

(cstruct xdg-client "struct wlr_xdg_client"
	 (:shell "shell" :type (:pointer (:struct xdg-shell)))
	 (:resource "resource" :type :pointer)
	 (:client "client" :type :pointer)
	 (:surfaces "surfaces" :type (:struct wl_list))
	 (:link "link" :type (:struct wl_list))
	 (:ping-serial "ping_serial" :type :uint32)
	 (:ping-timer "ping_timer" :type :pointer))

;; TODO: finish this:
(cstruct xdg-positioner "struct wlr_xdg_positioner")

(cstruct xdg-popup "struct wlr_xdg_popup")

(cstruct xdg-popup-grab "struct wlr_xdg_popup_grab")

(cenum xdg-surface-role
       ((:none "WLR_XDG_SURFACE_ROLE_NONE"))
       ((:toplevel "WLR_XDG_SURFACE_ROLE_TOPLEVEL"))
       ((:popup "WLR_XDG_SURFACE_ROLE_POPUP")))

(cstruct xdg-toplevel "struct wlr_xdg_toplevel")

(cstruct xdg-surface-configure "struct wlr_xdg_surface_configure")

(cstruct xdg-surface "struct wlr_xdg_surface"
	 (:client "client" :type (:pointer (:struct xdg-client)))
	 ;; actually of type wl_resource:
	 (:resource "resource" :type :pointer)
	 ;; (:surface "surface" (:pointer (:struct wlr_surface)))
	 (:link "link" :type (:struct wl_list)) ;; wlr_xdg_client::surfaces
	 (:role "role" :type xdg-surface-role)
	 ;; either a wlr_xdg_toplevel or a wlr_xdg_popup:
	 ;; (toplevel or popup union member)
	 (:wlr-object "toplevel" :type :pointer)
	 (:popups "popups" :type (:struct wl_list))
	 (:added "added" :type :bool)
	 (:configured "configured" :type :bool)
	 (:mapped "mapped" :type :bool)
	 (:config-serial "configure_serial" :type :uint32)
	 ;; wl_event_source
	 (:config-idle "configure_idle" :type :pointer)
	 (:config-next-serial "configure_next_serial" :type :uint32)
	 (:config-list "configure_list" :type (:struct wl_list))
	 (:has-next-geometry "has_next_geometry" :type :bool)
	 (:next-geometry "next_geometry" :type box)
	 (:geometry "geometry" :type box)
	 (:surface-destroy "surface_destroy" :type (:struct wl_listener))
	 (:surface-commit "surface_commit" :type (:struct wl_listener))
	 (:event-destroy "events.destroy" :type (:struct wl_signal))
	 (:event-ping-timeout "events.ping_timeout" :type (:struct wl_signal))
	 (:event-new-popup "events.new_popup" :type (:struct wl_signal))
	 #|
	 The `map` event signals that the shell surface is ready to be
	 managed by the compositor and rendered on the screen. At this point,
	 the surface has configured its properties, has had the opportunity
	 to bind to the seat to receive input events, and has a buffer that
	 is ready to be rendered. You can now safely add this surface to a
	 list of views.
	 |#
	 (:event-map "events.map" :type (:struct wl_signal))
	 #|
	 The `unmap` event signals that the surface is no longer in a state
	 where it should be shown on the screen. This might happen if the
	 surface no longer has a displayable buffer because either the
	 surface has been hidden or is about to be destroyed.
	 |#
	 (:event-unmap "events.unmap" :type (:struct wl_signal))
	 (:event-configure "events.configure" :type (:struct wl_signal))
	 ;; for protocol extensions:
	 (:event-ack-configure "events.ack_configure" :type (:struct wl_signal)))
