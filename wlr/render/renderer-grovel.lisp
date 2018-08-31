(in-package #:cl-wlroots/render/renderer)
(pkg-config-cflags "wlroots")
(cc-flags "-DWLR_USE_UNSTABLE")
(include "wlr/render/wlr_renderer.h")

(cenum renderer-read-pixels-flags
       ((:renderer-read-pixels-y-invert "WLR_RENDERER_READ_PIXELS_Y_INVERT")))

;; (cstruct renderer-impl "struct wlr_renderer_impl")

(cstruct renderer "struct wlr_renderer"
	 (:impl "impl" :type :pointer)
	 (:event-destroy "events.destroy" :type (:struct wl_signal)))
