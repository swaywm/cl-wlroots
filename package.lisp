;;;; package.lisp

;; (defpackage #:cl-wlr
;;   (:use #:cl))

;; (defpackage #:wayland-server
;;   (:documentation "Wayland server interface"))

;;(defpackage #:wlr)

(defpackage #:cl-wlroots/base
  (:use :cffi))

(defpackage #:cl-wlroots/log
  (:use :cffi :cl))

(defpackage #:cl-wlroots/backend/session
  (:use :cl :cffi :wayland-server-core))

(defpackage #:cl-wlroots/backend
  (:use :cl :cffi :wayland-server-core
	:cl-wlroots/backend/session))
