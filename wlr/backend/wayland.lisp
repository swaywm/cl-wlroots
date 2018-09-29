(in-package :cl-wlroots/backend/wayland)

(export '(wl-backend-create
	  wl-output-create
	  backend-is-wl-p
	  input-device-is-wl-p
	  output-is-wl-p))

(defcfun ("wlr_wl_backend_create" wl-backend-create) (:struct backend)
  "Creates a new wlr:wl-backend. This backend will be created with no outputs;
you must use wlr:wl-output_create to add them.

The `remote` argument is the name of the host compositor wayland socket. Set
to NULL for the default behaviour (WAYLAND_DISPLAY env variable or wayland-0
default)"
  (display :pointer)
  (remote (:pointer :char))
  (create-renderer-func :pointer))

(defcfun ("wlr_wl_output_create" wl-output-create) (:struct output)
  "Adds a new output to this backend. You may remove outputs by destroying them.
 Note that if called before initializing the backend, this will return NULL
 and your outputs will be created during initialization (and given to you via
 the output_add signal)."
  (backend (:pointer (:struct backend))))

(defcfun ("wlr_backend_is_wl" backend-is-wl-p) :bool
  "True if the given backend is a wl_backend."
  (backend (:pointer (:struct backend))))

(defcfun ("wlr_input_device_is_wl" input-device-is-wl-p) :bool
  "True if the given input device is a wl_input_device."
  (device (:struct input-device)))

(defcfun ("wlr_output_is_wl" output-is-wl-p) :bool
  "True if the given output is a wl_output."
  (output (:pointer (:struct output))))
