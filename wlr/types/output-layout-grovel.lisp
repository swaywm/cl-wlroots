(in-package #:cl-wlroots/types/output-layout)
(pkg-config-cflags "wlroots")
(cc-flags "-DWLR_USE_UNSTABLE")
(include "wlr/types/wlr_output_layout.h")

;; (cstruct output_layout_state "struct wlr_output_layout_state")

(cstruct output-layout "struct wlr_output_layout"
	 (:outputs "outputs" :type (:struct wl_list))
	 ;;(:state "state" :type (:pointer (:struct output_layout_state)))
	 (:state "state" :type :pointer)
	 (:event-add "events.add" :type (:struct wl_signal))
	 (:event-change "events.change" :type (:struct wl_signal))
	 (:event-destroy "events.destroy" :type (:struct wl_signal))
	 (:data "data" :type :pointer))


(cstruct output-layout-output "struct wlr_output_layout_output"
	 (:output "output" :type (:pointer (:struct output)))
	 (:x "x" :type :int)
	 (:y "y" :type :int)
	 ;; skipping link
	 ;;(:state "state" (:pointer (:struct output_layout_output_state))
	 (:state "state" :type :pointer))

(cenum direction
       ((:up "WLR_DIRECTION_UP"))
       ((:down "WLR_DIRECTION_DOWN"))
       ((:left "WLR_DIRECTION_LEFT"))
       ((:right "WLR_DIRECTION_RIGHT")))
