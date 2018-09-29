(in-package #:wlr/types/data-device)
(pkg-config-cflags "wlroots")
(cc-flags "-DWLR_USE_UNSTABLE")
(include "wlr/types/wlr_data_device.h")

(cstruct data-device-manager "struct wlr_data_device_manager"
	 (:global "global" :type :pointer)
	 (:resources "resources" :type (:struct wl_list))
	 (:data-sources "data_sources" :type (:struct wl_list))
	 (:display-destroy "display_destroy" :type (:struct wl_listener))
	 (:event-destroy "events.destroy" :type (:struct wl_signal))
	 (:data "data" :type (:pointer :void)))

;; TODO: actually fill this out
(cstruct data-source "struct wlr_data_source")

(cstruct data-offer "struct wlr_data_offer"
	 ;; (:resource "resource" :type (:pointer (:struct wl-resource))))
	 (:source "source" :type (:pointer (:struct data-source)))
	 (:actions "actions" :type :uint32)
	 ;; is actually of type wayland-server-protocol:wl-data-device-manager-dnd-action
	 (:preferred-action "preferred_action" :type :int)
	 (:in-ask "in_ask" :type :bool)
	 (:source-destroy "source_destroy" :type (:struct wl_listener)))

(cstruct data-source-impl "struct wlr_data_source_impl"
	 (:send "send" :type :pointer)
	 (:accept "accept" :type :pointer)
	 (:cancel "cancel" :type :pointer)
	 (:dnd-drop "dnd_drop" :type :pointer)
	 (:dnd-finish "dnd_finish" :type :pointer)
	 (:dnd-action "dnd_action" :type :pointer))

;; TODO: fill this out
 (cstruct drag-icon "struct wlr_drag_icon")

;; TODO:fill this out
 (cstruct drag "struct wlr_drag")

(cstruct drag-motion-event "struct wlr_drag_motion_event"
	 (:drag "drag" :type (:pointer (:struct drag)))
	 (:time "time" :type :uint32)
	 (:sx "sx" :type :double)
	 (:sy "sy" :type :double))
