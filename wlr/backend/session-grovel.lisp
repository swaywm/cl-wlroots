(in-package #:wlr/backend/session)
(pkg-config-cflags "wlroots")
(include "wlr/backend/session.h")

;; not used by us, doesn't compile with this;
;; (cstruct session_impl "struct session_impl")

(cstruct device "struct wlr_device"
	 (fd "fd" :type :int)
	 (sig "signal" :type :pointer))

(cstruct session "struct wlr_session"
	 (impl "impl" :type :pointer)
	 (session_signal "session_signal" :type (:struct wl_signal))
	 (active "active" :type :bool)
	 (vtnr "vtnr" :type :unsigned-int)
	 (seat "seat" :type :char :count 256)
	 ;; don't have libudev for common lisp:
	 (udev "udev" :type :pointer)
	 ;; don't have a representation of wl_event_source:
	 (udev_event "udev_event" :type :pointer)
	 (devices "devices" :type (:struct wl_list))
	 (display_destroy "display_destroy" :type (:struct wl_listener)))
