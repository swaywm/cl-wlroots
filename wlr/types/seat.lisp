(in-package #:cl-wlroots/types/seat)

(export '(seat))

(defcfun ("wlr_seat_create" seat-create) (:pointer (:struct seat))
  (display :pointer)
  (name :string))

(defcfun ("wlr_seat_destroy" seat-destroy) :void
  (seat (:pointer (:struct seat))))
