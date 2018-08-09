(in-package #:cl-wlroots/types/seat)
(pkg-config-cflags "wlroots")
(cc-flags "-DWLR_USE_UNSTABLE")
(include "wlr/types/wlr_seat.h")


;; commented out items are fields that are probably needed, but cannot be
;; used as their foriegn type hasn't been determined yet.
(cstruct seat "struct wlr_seat"
	 (:global "global"   :type :pointer)
	 (:display "display" :type :pointer)
	 (:clients "clients" :type (:struct wl_list))
	 (:drag-icons "drag_icons" :type (:struct wl_list))

	 (:name "name" :type :string)
	 (:capabilities "capabilities" :type :uint32)

	 ;; (:last-event "last_event")
	 (:selection-source "selection_source" :type (:pointer (:struct data-source)))
	 (:selection_serial "selection_serial" :type :uint32)

	 ;; (:primary-selection-source "primary_selection_source" :type (:pointer (:struct primary-selection-source)))
	 (:primary-selection-serial "primary_selection_serial" :type :uint32)

	 (:drag "drag" :type (:pointer (:struct drag)))
	 (:drag-source "drag_source" :type (:pointer (:struct data-source)))
	 (:drag-serial "drag_serial" :type :uint32)
	 ;; (:pointer-state "pointer_state" :type (:struct seat-pointer-state))
	 ;; (:keyboard-state "keyboard_state" :type (:struct seat-keyboard-state))
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

;; (cstruct seat_client "wlr_seat_client"
;; 	 (:client "client" (:pointer (:struct client)))
;; 	 (:seat   "seat"   (:pointer (:struct seat)))
