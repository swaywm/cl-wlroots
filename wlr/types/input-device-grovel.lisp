(in-package #:cl-wlroots/types/input-devices)
(pkg-config-cflags "wlroots")
(cc-flags "-DWLR_USE_UNSTABLE")
(include "wlr/types/wlr_keyboard.h")
(include "wlr/types/wlr_pointer.h")
(include "wlr/types/wlr_touch.h")
(include "wlr/types/wlr_tablet_tool.h")
(include "wlr/types/wlr_tablet_pad.h")
(include "wlr/types/wlr_input_device.h")

(cenum button-state
       ((:button-released "WLR_BUTTON_RELEASED"))
       ((:button-pressed "WLR_BUTTON_PRESSED")))

(cenum input-device-type
       ((:keyboard "WLR_INPUT_DEVICE_KEYBOARD"))
       ((:pointer "WLR_INPUT_DEVICE_POINTER"))
       ((:touch "WLR_INPUT_DEVICE_TOUCH"))
       ((:tablet-tool "WLR_INPUT_DEVICE_TABLET_TOOL"))
       ((:tablet-pad "WLR_INPUT_DEVICE_TABLET_PAD")))

(cstruct input-device "struct wlr_input_device")

;; wlr_keyboard.h

(constant (+led-count+ "WLR_LED_COUNT"))

(cenum keyboard-led
       ((:led-num-lock "WLR_LED_NUM_LOCK"))
       ((:led-caps-lock "WLR_LED_CAPS_LOCK"))
       ((:led-scroll-lock "WLR_LED_SCROLL_LOCK")))

(constant (+modifier-count+ "WLR_MODIFIER_COUNT") :type integer)

(cenum keyboard-modifier
       ((:shift "WLR_MODIFIER_SHIFT"))
       ((:caps "WLR_MODIFIER_CAPS"))
       ((:ctrl "WLR_MODIFIER_CTRL"))
       ((:alt "WLR_MODIFIER_ALT"))
       ((:mod2 "WLR_MODIFIER_MOD2"))
       ((:mod3 "WLR_MODIFIER_MOD3"))
       ((:logo "WLR_MODIFIER_LOGO"))
       ((:mods "WLR_MODIFIER_MOD5")))

(constant (+keyboard-keys-cap+ "WLR_KEYBOARD_KEYS_CAP") :type integer)

(cstruct keyboard-modifiers "struct wlr_keyboard_modifiers"
	 (:depressed "depressed" :type  "xkb:mod-mask")
	 (:latched "latched" :type  "xkb:mod-mask")
	 (:locked "locked" :type  "xkb:mod-mask")
	 (:group "group" :type  "xkb:mod-mask"))

(cstruct keyboard "struct wlr_keyboard"
	 (:keymap-id "keymap_fd" :type :int)
	 (:keymap-size "keymap_size" :type size-t)
	 (:keymap "keymap" :type :pointer)
	 (:xkb-state "xkb_state" :type :pointer)
	 (:led-indexes "led_indexes" :type "xkb:led-index" :count "WLR_LED_COUNT")
	 (:mod-indexes "mod_indexes" :type "xkb:mod-index" :count "WLR_MODIFIER_COUNT")
	 (:keycodes "keycodes" :type :uint32 :count "WLR_KEYBOARD_KEYS_CAP")
	 (:num_keycodes "num_keycodes" :type size-t)
	 (:modifiers "modifiers" :type (:pointer (:struct keyboard-modifiers)))
	 ;; may want to change the repeat-info into a seperate struct:
	 (:repeat-info-rate "repeat_info.rate" :type :int32)
	 (:repeat-info-delay "repeat_info.delay" :type :int32)
	 (:event-key "events.key" :type (:struct wl_signal))
	 (:event-modifiers "events.modifiers" :type (:struct wl_signal))
	 (:event-keymap "events.keymap" :type (:struct wl_signal))
	 (:event-repeat-info "events.repeat_info" :type (:struct wl_signal)))

(cenum key-state
       ((:key-relased "WLR_KEY_RELEASED"))
       ((:key-pressed "WLR_KEY_PRESSED")))

(cstruct event-keyboard-key "struct wlr_event_keyboard_key"
	 (time-msec "time_msec" :type :uint32)
	 (keycode "keycode" :type :uint32)
	 (update-state "update_state" :type :bool)
	 (state "state" :type key-state))

;; end of wlr_keyboard.h

;; start of wlr_pointer.h

(cstruct pointer "struct wlr_pointer"
	 (:event-motion "events.motion" :type (:struct wl_signal))
	 (:event-motion-absolute "events.motion_absolute" :type (:struct wl_signal))
	 (:event-button "events.button" :type (:struct wl_signal))
	 (:event-axis "events.axis" :type (:struct wl_signal))
	 (:data "data" :type :pointer))

(cstruct event-pointer-motion "struct wlr_event_pointer_motion"
	 (:input-device "device" :type (:pointer (:struct input-device)))
	 (:time-msec "time_msec" :type :uint32)
	 (:delta-x "delta_x" :type :double)
	 (:delta-y "delta_y" :type :double))

(cstruct event-pointer-motion-absolute "struct wlr_event_pointer_motion_absolute"
	 (:device "device" :type (:pointer (:struct input-device)))
	 (:time-msec "time_msec" :type :uint32)
	 ;; From 0..1
	 (:x "x" :type :double)
	 (:y "y" :type :double))

(cstruct event-pointer-button "struct wlr_event_pointer_button"
	 (:device "device" :type (:pointer (:struct input-device)))
	 (:time-msec "time_msec" :type :uint32)
	 (:button "button" :type :uint32)
	 (:button-state "state" :type button-state))

(cenum axis-source
       ((:wheel "WLR_AXIS_SOURCE_WHEEL"))
       ((:finger "WLR_AXIS_SOURCE_FINGER"))
       ((:continuous "WLR_AXIS_SOURCE_CONTINUOUS"))
       ((:wheel-tilt "WLR_AXIS_SOURCE_WHEEL_TILT")))

(cenum axis-orientation
       ((:vertical "WLR_AXIS_ORIENTATION_VERTICAL"))
       ((:horizontal "WLR_AXIS_ORIENTATION_HORIZONTAL")))

(cstruct event-pointer-axis  "struct wlr_event_pointer_axis"
	 (:device "device" :type (:pointer (:struct input-device)))
	 (:time-msec "time_msec" :type :uint32)
	 (:source "source" :type axis-source)
	 (:orientation "orientation" :type axis-orientation)
	 (:delta "delta" :type :double)
	 (:delta-discrete "delta_discrete" :type :int32))

;; end wlr_pointer.h

;; skip touch and various tablet stuff for now

;; more wlr_input_device.h:

(cstruct input-device "struct wlr_input_device"
	 (:type "type" :type input-device-type)
	 (:vendor "vendor" :type :uint)
	 (:product "product" :type :uint)
	 (:name "name" :type :string)
	 ;; Or 0 if not applicable to this device
	 (:width-nm " width_mm" :type :double)
	 (:height-mn "height_mm" :type :double)
	 (:output-name "output_name" :type :string)

	 ;; wlr_input_device.type determines which of these is valid
	(:keyboard "keyboard" :type (:pointer (:struct keyboard)))
	(:pointer "pointer" :type (:pointer (:struct pointer)))
	;; TODO: implement these interfaces:
	;; (:touch "touch" :type (:pointer (:struct touch)))
	;; (:tablet "table" :type (:pointer (:struct tablet)))
	;; (:table-pad "tablet_pad" :type (:pointer (:struct tablet-pad)))
	(:event-destroy "events.destroy" :type (:struct wl_signal))
	(:link "link" :type (:struct wl_list)))
