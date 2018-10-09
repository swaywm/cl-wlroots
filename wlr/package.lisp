;;;; package.lisp



(defpackage #:wlr/error
  (:use :cl))

(defpackage #:wlr/wlr-version
  (:use :cl :alexandria))

(defpackage #:wlr/config)

(defpackage #:wlr/base
  (:use :cl :cffi #:wlr/error))

(defpackage #:wlr/common
  (:use :cffi :cl))

(defpackage #:wlr/util/log
  (:use :cffi :cl))

(defpackage #:wlr/types/box
  (:use :cl :cffi :wayland-server-protocol))

(defpackage #:wlr/render/renderer
  (:use :cffi :cl :wayland-server-core :egl :wayland-server-core))

(defpackage #:wlr/backend/session
  (:use :cl :cffi :wayland-server-core :wlr/common
	#:wlr/base))

(defpackage #:wlr/backend
  (:use :cl :cffi :wayland-server-core
	:wlr/backend/session
	:wlr/render/renderer
	:wlr/base))

(defpackage #:wlr/types/output
  (:use :cffi :cl :wayland-server-core #:wlr/backend))

(defpackage #:wlr/types/output-layout
  (:use :cffi :cl :wayland-server-core #:wlr/types/output))

(defpackage #:wlr/types/data-device
  (:use :cffi :cl :wayland-server-core
	#:wlr/base))

(defpackage #:wlr/types/output-damage
  (:use :cffi :cl :wayland-server-core #:wlr/base
	#:wlr/types/output))

(defpackage #:wlr/types/input-devices
  (:use :cffi :cl :wayland-server-core #:wlr/common))

(defpackage #:wlr/backend/wayland
  (:use :cl :cffi :wlr/base :wlr/backend
	:wlr/types/input-devices
	:wlr/types/output
	:wayland-server-core))

(defpackage #:wlr/types/seat
  (:use :cffi :cl :wayland-server-core #:wlr/types/data-device
	#:wlr/types/input-devices #:wlr/common #:wlr/base))

(defpackage #:wlr/types/cursor
  (:use :cffi :cl :wayland-server-core #:wlr/types/input-devices
	#:wlr/types/box #:wlr/types/output-layout #:wlr/types/output
	#:wlr/base))
