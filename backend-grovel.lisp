(in-package #:cl-wlroots/backend)
(pkg-config-cflags "wlroots")
(cc-flags "-DWLR_USE_UNSTABLE")
(include "wlr/backend.h")

(cstruct wlr_backend "struct wlr_backend"
	 (impl "impl" :type :pointer)
	 (:event-destroy "events.destroy"
	 		:type (:struct wl_signal))
	 (:event-new-input "events.new_input"
	 		  :type (:struct wl_signal))
	 (:event-new-output "events.new_output"
	 		   :type (:struct wl_signal)))
