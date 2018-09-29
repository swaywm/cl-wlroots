(in-package #:wlr/types/seat)

(export '(seat
	  seat-create
	  seat-destroy
	  seat-client-for-wl-client
	  seat-set-capabilities
	  seat-set-keyboard
	  seat-get-keyboard
	  seat-notify-key
	  seat-keyboard-notify-enter
	  seat-keyboard-notify-modifiers))

(defcfun "wlr_seat_create" (:pointer (:struct seat))
  (display :pointer)
  (name :string))

(defun seat-create (display name)
  (let ((new-seat (wlr-seat-create display name)))
    (when (cffi:null-pointer-p new-seat)
      (error 'initialization-error 'seat))
    new-seat))

(defcfun ("wlr_seat_destroy" seat-destroy) :void
  (seat (:pointer (:struct seat))))

(defcfun ("wlr_seat_client_for_wl_client" seat-client-for-wl-client) (:pointer (:struct seat-client))
  (seat (:pointer (:struct seat)))
  (wl-client :pointer))

(defcfun ("wlr_seat_set_capabilities" seat-set-capabilities) :void
  (wlr-seat :uint32))

(defcfun ("wlr_seat_set_keyboard" seat-set-keyboard) :void
  (seat (:pointer (:struct seat)))
  (device (:pointer (:struct input-device))))

(defcfun ("wlr_seat_get_keyboard" seat-get-keyboard) (:pointer (:struct keyboard))
  (seat (:pointer (:struct seat))))

(defcfun ("wlr_seat_keyboard_notify_key" seat-notify-key) :void
  " * Notify the seat that a key has been pressed on the keyboard. Defers to any
 * keyboard grabs."
  (seat (:pointer (:struct seat)))
  (time :uint32)
  (key :uint32)
  (state :uint32))

(defcfun ("wlr_seat_keyboard_notify_modifiers" seat-keyboard-notify-modifiers) :void
  " * Notify the seat that the modifiers for the keyboard have changed. Defers to
 * any keyboard grabs."
  (seat (:pointer (:struct seat)))
  (modifiers (:pointer (:struct keyboard-modifiers))))

(defcfun ("wlr_seat_keyboard_notify_enter" seat-keyboard-notify-enter) :void
  " * Notify the seat that the keyboard focus has changed and request it to be the
 * focused surface for this keyboard. Defers to any current grab of the seat's
 * keyboard."
  (seat (:pointer (:struct seat)))
  (surface :pointer)
  (keycodes (:pointer :uint32))
  (num-keycodes size-t)
  (modifiers (:pointer (:struct keyboard-modifiers))))
