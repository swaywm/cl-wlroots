(in-package #:wlr/types/output-damage)
(pkg-config-cflags "wlroots")
(cc-flags "-DWLR_USE_UNSTABLE")
(include "wlr/types/wlr_output_damage.h")

(cstruct output-damage "struct wlr_output_damage"
	 (:output "output" :type (:struct output))
	 (:event-damage-frame "events.frame" :type (:struct wl_signal))
	 (:event-destroy "events.destroy" :type (:struct wl_signal)))
