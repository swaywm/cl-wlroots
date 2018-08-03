(in-package #:cl-wlroots/backend)

(export '(wlr_backend
	  backend-events
	  backend-autocreate
	  backend-start
	  backend-destroy))

;; (defcstruct backend-events
;;   (destroy (:struct wl_signal))
;;   (new_input (:struct wl_signal))
;;   (new_output (:struct wl_signal)))

(defcfun ("wlr_backend_autocreate" backend-autocreate) (:pointer (:struct wlr_backend))
  (display :pointer)
  (create_renderer_func :pointer))

(defcfun ("wlr_backend_start" backend-start) :bool
  (backend (:pointer (:struct wlr_backend))))

(defcfun ("wlr_backend_destroy" backend-destroy) :void
  (backend (:pointer (:struct wlr_backend))))

;; (defcfun "wlr_backend_get_renderer" (:pointer (:struct wlr_renderer))
;;   (backend (:pointer (:struct wlr_backend))))
