(in-package #:cl-wlroots/backend)

(export '(backend
	  backend-events
	  backend-autocreate
	  backend-start
	  backend-destroy
	  backend-get-renderer))

;; (defcstruct backend-events
;;   (destroy (:struct wl_signal))
;;   (new_input (:struct wl_signal))
;;   (new_output (:struct wl_signal)))

(defcfun ("wlr_backend_autocreate" backend-autocreate) (:pointer (:struct backend))
  (display :pointer)
  (create_renderer_func :pointer))

(defcfun ("wlr_backend_start" backend-start) :bool
  (backend (:pointer (:struct backend))))

(defcfun ("wlr_backend_destroy" backend-destroy) :void
  (backend (:pointer (:struct backend))))

(defcfun ("wlr_backend_get_renderer" backend-get-renderer) :pointer ;; (:pointer (:struct renderer))
  (backend :pointer))
  ;; (backend (:pointer (:struct backend))))
