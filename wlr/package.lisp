;;;; package.lisp



(defpackage #:cl-wlroots/wlr-version
  (:use :cl :alexandria))

(defpackage #:cl-wlroots/config)

(defpackage #:cl-wlroots/base
  (:use :cl :cffi))

(defpackage #:cl-wlroots/common
  (:use :cffi :cl))

(defpackage #:cl-wlroots/util/log
  (:use :cffi :cl))

(defpackage #:cl-wlroots/types/box
  (:use :cl :cffi :wayland-server-protocol))

(defpackage #:cl-wlroots/render/renderer
  (:use :cffi :cl :wayland-server-core :egl :wayland-server-core))

(defpackage #:cl-wlroots/backend/session
  (:use :cl :cffi :wayland-server-core :cl-wlroots/common
	#:cl-wlroots/base))

(defpackage #:cl-wlroots/backend
  (:use :cl :cffi :wayland-server-core
	:cl-wlroots/backend/session
	:cl-wlroots/render/renderer
	:cl-wlroots/base))

(defpackage #:cl-wlroots/types/output
  (:use :cffi :cl :wayland-server-core #:cl-wlroots/backend))

(defpackage #:cl-wlroots/types/output-layout
  (:use :cffi :cl :wayland-server-core #:cl-wlroots/types/output))

(defpackage #:cl-wlroots/types/data-device
  (:use :cffi :cl :wayland-server-core
	#:cl-wlroots/base))

(defpackage #:cl-wlroots/types/output-damage
  (:use :cffi :cl :wayland-server-core #:cl-wlroots/base
	#:cl-wlroots/types/output))

(defpackage #:cl-wlroots/types/input-devices
  (:use :cffi :cl :wayland-server-core #:cl-wlroots/common))

(defpackage #:cl-wlroots/backend/wayland
  (:use :cl :cffi :cl-wlroots/backend :cl-wlroots/types/input-devices :wayland-server-core))

(defpackage #:cl-wlroots/types/seat
  (:use :cffi :cl :wayland-server-core #:cl-wlroots/types/data-device
	#:cl-wlroots/types/input-devices #:cl-wlroots/common #:cl-wlroots/base))

(defpackage #:cl-wlroots/types/cursor
  (:use :cffi :cl :wayland-server-core #:cl-wlroots/types/input-devices
	#:cl-wlroots/types/box #:cl-wlroots/types/output-layout #:cl-wlroots/types/output
	#:cl-wlroots/base))
