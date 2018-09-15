(in-package #:cl-wlroots/types/seat)

(export '(seat
	  seat-create
	  seat-destroy))

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
