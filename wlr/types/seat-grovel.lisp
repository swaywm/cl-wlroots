(in-package #:wlr/types/seat)
(pkg-config-cflags "wlroots")
(cc-flags "-DWLR_USE_UNSTABLE")
(include "wlr/types/wlr_seat.h")

(cstruct seat "struct wlr_seat")

(cstruct seat-client "struct wlr_seat_client"
	 (:client "client" :type :pointer)
	 (:seat "seat" :type (:pointer (:struct seat)))
	 (:resources "resources" :type (:struct wl_list))
	 (:pointers "pointers" :type (:struct wl_list))
	 (:keyboards "keyboards" :type (:struct wl_list))
	 (:touches "touches" :type (:struct wl_list))
	 (:data-devices "data_devices" :type (:struct wl_list))
	 (:primary-selection_devices "primary_selection_devices" :type (:struct wl_list))
	 (:event-destroy "events.destroy" :type (:struct wl_signal))
	 (:link "link" :type (:struct wl_list)))

(cstruct  seat-pointer-state "struct wlr_seat_pointer_state"
	  (:seat "seat" :type (:struct seat))
	  (:focused-client "focused_client" :type (:struct seat))
	  ;; wlr_surface
	  (:focused_surface "focused_surface" :type :pointer)
	  ;; wlr_seat_pointer_grab
	  (:grab "grab" :type :pointer)
	  ;; wlr_seat_pointer_grab
	  (:default-grab "default_grab" :type :pointer)

	  (:grab-button "grab_button" :type :uint32)
	  (:grab-serial "grab_serial" :type :uint32)
	  (:grab-time "grab_time" :type :uint32)
	  (:surface-destroy "surface_destroy" :type(:struct wl_listener)))

(cstruct seat-keyboard-grab "struct wlr_seat_keyboard_grab")
(cstruct seat-touch-grab "struct wlr_seat_touch_grab")
;; (cstruct seat-pointer-grab

(cstruct seat-keyboard-state "struct wlr_seat_keyboard_state"
	 (:seat "seat" :type (:pointer (:struct seat)))
	 (:keyboard "keyboard" :type (:struct keyboard))
	 (:focused_client "focused_client" :type (:struct seat-client))
	 ;; (:focused_surface "focused_surface" :type (:struct surface))
	 (:keyboard_destroy "keyboard_destroy" :type (:struct wl_listener))
	 (:keyboard_keymap "keyboard_keymap" :type (:struct wl_listener))
	 (:keyboard_repeat_info "keyboard_repeat_info" :type (:struct wl_listener))
	 (:surface_destroy "surface_destroy" :type (:struct wl_listener))
	 (:grab "grab" :type (:struct seat-keyboard-grab))
	 (:default_grab "default_grab" :type (:struct seat-keyboard-grab)))

;; commented out items are fields that are probably needed, but cannot be
;; used as their foriegn type hasn't been determined yet.
(cstruct seat "struct wlr_seat"
	 (:global "global"   :type :pointer)
	 (:display "display" :type :pointer)
	 (:clients "clients" :type (:struct wl_list))
	 (:drag-icons "drag_icons" :type (:struct wl_list))

	 (:name "name" :type :string)
	 (:capabilities "capabilities" :type :uint32)

	 (:last-event "last_event" :type (:struct timespec))
	 (:selection-source "selection_source" :type (:pointer (:struct data-source)))
	 (:selection_serial "selection_serial" :type :uint32)

	 ;; (:primary-selection-source "primary_selection_source" :type (:pointer (:struct primary-selection-source)))
	 (:primary-selection-serial "primary_selection_serial" :type :uint32)

	 (:drag "drag" :type (:pointer (:struct drag)))
	 (:drag-source "drag_source" :type (:pointer (:struct data-source)))
	 (:drag-serial "drag_serial" :type :uint32)
	 (:pointer-state "pointer_state" :type (:struct seat-pointer-state))
	 (:keyboard-state "keyboard_state" :type (:struct seat-keyboard-state))
	 ;; (:touch-state "touch_state" :type (:struct seat-touch-state))

	 (:display-destroy "display_destroy" :type (:struct wl_listener))
	 (:selection-source-destroy "selection_source_destroy" :type (:struct wl_listener))
	 (:primary-selection-source-destroy "primary_selection_source_destroy":type (:struct wl_listener))
	 (:drag-source-destroy "drag_source_destroy" :type (:struct wl_listener))

	 (:event-pointer-grab-begin "events.pointer_grab_begin" :type (:struct wl_signal))
	 (:event-pointer-grab-end "events.pointer_grab_end" :type (:struct wl_signal))

	 (:event-keyboard-grab-begin "events.keyboard_grab_begin" :type (:struct wl_signal))
	 (:event-keyboard-grab-end "events.keyboard_grab_end" :type (:struct wl_signal))

	 (:event-touch-grab-begin "events.touch_grab_begin" :type (:struct wl_signal))
	 (:event-touch-grab-end "events.touch_grab_end" :type (:struct wl_signal))

	 (:event-request-set-cursor "events.request_set_cursor" :type (:struct wl_signal))

	 (:event-selection "events.selection" :type (:struct wl_signal))
	 (:event-primary-selection "events.primary_selection" :type (:struct wl_signal))

	 (:event-start-drag "events.start_drag" :type (:struct wl_signal))
	 (:event-new-drag-icon "events.new_drag_icon" :type (:struct wl_signal))

	 (:event-destroy "events.destroy" :type (:struct wl_signal))

	 (:data "data" :type :pointer))


(cstruct pointer-grab-interface "struct wlr_pointer_grab_interface"
	 (:enter "enter" :type :pointer)
	 (:motion "motion" :type :pointer)
	 (:axis "axis" :type :pointer)
	 (:cancel "cancel" :type :pointer))

(cstruct keyboard-grab-interface "struct wlr_keyboard_grab_interface"
	 (:enter "enter" :type :pointer)
	 (:key "key" :type :pointer)
	 (:modifiers "modifiers" :type :pointer)
	 (:cancel "cancel" :type :pointer))

(cstruct touch-grab-interface "struct wlr_touch_grab_interface"
	 (:down "down" :type :pointer)
	 (:up "up" :type :pointer)
	 (:motion "motion" :type :pointer)
	 (:enter "enter" :type :pointer)
	 ;; XXX this will conflict with the actual touch cancel which is different so
	 ;; we need to rename this
	(:cancel "cancel" :type :pointer))
