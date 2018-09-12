;;;; package.lisp

;; (defpackage #:cl-wlr
;;   (:use #:cl))

;; (defpackage #:wayland-server
;;   (:documentation "Wayland server interface"))

;;(defpackage #:wlr)

(defpackage #:cl-wlroots/base
  (:use :cffi))

(defpackage #:cl-wlroots/common
  (:use :cffi :cl))

(defpackage #:cl-wlroots/util/log
  (:use :cffi :cl))

(defpackage #:cl-wlroots/types/box
  (:use :cl :cffi :wayland-server-protocol))

(defpackage #:cl-wlroots/render/renderer
  (:use :cffi :cl :wayland-server-core :egl :wayland-server-core))

(defpackage #:cl-wlroots/backend/session
  (:use :cl :cffi :wayland-server-core :cl-wlroots/common))

(defpackage #:cl-wlroots/backend
  (:use :cl :cffi :wayland-server-core
	:cl-wlroots/backend/session
	:cl-wlroots/render/renderer))

(defpackage #:cl-wlroots/types/output
  (:use :cffi :cl :wayland-server-core :cl-wlroots/backend))

(defpackage #:cl-wlroots/types/output-layout
  (:use :cffi :cl :wayland-server-core :cl-wlroots/types/output))

(defpackage #:cl-wlroots/types/data-device
  (:use :cffi :cl :wayland-server-core))

(defpackage #:cl-wlroots/types/seat
  (:use :cffi :cl :wayland-server-core :cl-wlroots/types/data-device))

(defpackage #:cl-wlroots/types/output-damage
  (:use :cffi :cl :wayland-server-core :cl-wlroots/types/output))

(defpackage #:cl-wlroots/types/input-devices
  (:use :cffi :cl :wayland-server-core :cl-wlroots/common))

(defpackage #:cl-wlroots/types/cursor
  (:use :cffi :cl :wayland-server-core #:cl-wlroots/types/input-devices
	#:cl-wlroots/types/box #:cl-wlroots/types/output-layout #:cl-wlroots/types/output))
