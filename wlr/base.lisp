(in-package #:cl-wlroots/base)

(define-foreign-library libwlroots
  (:unix (:or "libwlroots.so.0"))
  (t (:default "libwlroots")))

(use-foreign-library libwlroots)

;; (define-foreign-library libwayland-server
;;   (:unix (:or "libwayland-server.so.0"))
;;   (t (:default "libwayland-server")))

;; (use-foreign-library libwayland-server)
