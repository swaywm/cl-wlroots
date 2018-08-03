(in-package #:cl-wlroots/types/wlr-output)
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

(cstruct wlr_output "struct wlr_output")

(cstruct output_cursor "struct wlr_output_cursor"
	 (output "output" :type (:pointer (:struct wlr_output)))
	 (x "x" :type :double)
	 (y "y" :type :double)
	 (enabled "enabled" :type :bool)
	 (visible "visible" :type :bool)
	 (width "width" :type :uint32)
	 (height "height" :type :uint32)
	 ;; TODO: hotspot_x, hotspot_y
	 ;; skipping link
	 ;; TODO: wlr_texture)
	 )


(cstruct wlr_output "struct wlr_output"
	 (:backend "backend" :type (:pointer (:struct wlr_backend)))
	 (:display "display" :type :pointer)
	 ;; skipping global, wl_list
	 (:name "name" :type :char :count 24)
	 (:make "make" :type :char :count 48)
	 (:model "model" :type :char :count 16)
	 (:serial "serial" :type :char :count 16)
	 (:phys-width "phys_width" :type :int32)
	 (:pys-height "phys_height" :type :int32)
	 ;; skipping struct wl_list modes
	 (:current-mode "current_mode"
			:type (:pointer (:struct output_mode))))
