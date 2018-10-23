(in-package #:wlr/types/compositor)

(pkg-config-cflags "wlroots")
(cc-flags "-DWLR_USE_UNSTABLE")
(include "wlr/types/wlr_compositor.h")

(cstruct subcompositor "struct wlr_subcompositor"
	 (:global "global" :type :pointer)
	 (:resources "resources" :type (:struct wl_list))
	 (:subsurface-resources "subsurface_resources" :type (:struct wl_list)))

(cstruct compositor "struct wlr_compositor"
	 (:global "global" :type :pointer)
	 (:resources "resources" :type (:struct wl_list))
	 (:renderer "renderer" :type (:pointer (:struct renderer)))
	 (:surface-resources "surface_resources" :type (:struct wl_list))
	 (:region-resources "region_resources" :type (:struct wl_list))
	 (:subcompositor "subcompositor" :type (:struct subcompositor))
	 (:display-destroy "display_destroy" :type (:struct wl_listener))
	 (:event-new-surface "events.new_surface" :type (:struct wl_signal))
	 (:event-destroy "events.destroy" :type (:struct wl_signal)))
