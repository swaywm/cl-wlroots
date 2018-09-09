(in-package #:cl-wlroots/types/input-devices)

;; keyboard.lisp
(export '(;; all of the grovelled types:
	 button-state
	 input-device-type
	 +led-count+
	 keyboard-led
	 +modifier-count+
	 keyboard-modifier
	 keyboard-modifiers
	 keyboard
	 key-state
	 event-keyboard-key
	 pointer
	 event-pointer-motion
	 event-pointer-motion-absolute
	 event-pointer-button
	 axis-source
	 axis-orientation
	 event-pointer-axis
	 input-device
	 ;; functions
	 keyboard-set-keymap
	 keyboard-set-repeat-info
	 keyboard-led-update
	 keyboard-get-modifiers))

(defcfun ("wlr_keyboard_set_keymap" keyboard-set-keymap) :void
  (kb (:pointer (:struct keyboard)))
  (keymap (:pointer (:struct xkb:keymap))))

(defcfun ("wlr_keyboard_set_repeat_info" keyboard-set-repeat-info) :void
  "Sets the keyboard repeat info. `rate` is in key repeats/second and delay is
in milliseconds."
  (kb (:pointer (:struct keyboard)))
  (rate :int32)
  (delat :int32))

(defcfun ("wlr_keyboard_led_update" keyboard-led-update) :void
  (keyboard (:pointer (:struct keyboard)))
  (leds :uint32))

(defcfun ("wlr_keyboard_get_modifiers" keyboard-get-modifiers) :uint32
  (keyboard (:pointer (:struct keyboard))))
