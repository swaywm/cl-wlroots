(in-package #:cl-wlroots/types/seat)

(export '(seat
	  seat-create
	  seat-destroy))

(defcfun ("wlr_seat_create" seat-create) (:pointer (:struct seat))
  (display :pointer)
  (name :string))

(defcfun ("wlr_seat_destroy" seat-destroy) :void
  (seat (:pointer (:struct seat))))

(defcfun ("wlr_seat_client_for_wl_client" seat-client-for-wl-client) (:pointer (:struct (struct wlr_seat *wlr_seat,
		struct wl_client *wl_client)

(defcfun ("wlr_seat_set_capabilities" seat-set-capabilities) :void
  (wlr-seat :uint32))
