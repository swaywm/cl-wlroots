(in-package #:cl-wlroots/types/output)
(pkg-config-cflags "wlroots")
(cc-flags "-DWLR_USE_UNSTABLE")
(include "wlr/types/wlr_output.h")

(cstruct output_mode "struct wlr_output_mode"
	 (:flags "flags" :type :uint32)
	 (:width "width" :type :int32)
	 (:height "height" :type :int32)
	 (:refresh "refresh" :type :int32)
	 ;;; not including the link:
	 )

(cstruct output "struct wlr_output")

(cstruct output_cursor "struct wlr_output_cursor"
	 (:output "output" :type (:pointer (:struct output)))
	 (:x "x" :type :double)
	 (:y "y" :type :double)
	 (:enabled "enabled" :type :bool)
	 (:visible "visible" :type :bool)
	 (:width "width" :type :uint32)
	 (:height "height" :type :uint32)
	 ;; TODO: hotspot_x, hotspot_y
	 ;; skipping link
	 ;; TODO: wlr_texture)
	 )


(cstruct output "struct wlr_output"
	 (:backend "backend" :type (:pointer (:struct backend)))
	 (:display "display" :type :pointer)
	 ;; skipping global, wl_list
	 (:name "name" :type :string)
	 (:make "make" :type :string)
	 (:model "model" :type :string)
	 (:serial "serial" :type :string)
	 (:phys-width "phys_width" :type :int32)
	 (:pys-height "phys_height" :type :int32)
	 (:modes "modes" :type wayland-server-core:wl_list)
	 (:current-mode "current_mode"
			:type (:pointer (:struct output_mode)))
	 (:width "width" :type :int32)
	 (:height "height" :type :int32)
	 (:refresh "refresh" :type :int32)
	 (:enabled "enabled" :type :bool)
	 (:scale "scale" :type :float)
	 ;; (:subpixel "subpixel" :type wayland-server-protocol:wl-output-subpixel)
	 ;; (:transform "transform" :type wayland-server-protocol:wl-output-transform)
	 (:subpixel "subpixel" :type :int)
	 (:transform "transform" :type :int)
	 (:needs-swap "needs_swap" :type :bool)
	 ;; (:damage "damage" :type pixman:region32_t)
	 (:frame-pending "frame_pending" :type :bool)
	 (:transform-matrix "transform_matrix" :type :float)
	 (:event-frame "events.frame" :type (:struct wl_signal))
	 (:event-destroy "events.destroy" :type (:struct wl_signal)))
