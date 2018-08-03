;; (defpackage #:cl-wlroots/backend/session
;;   (:use :cl :cffi :cffi-grovel :wayland-server-core))

(in-package #:cl-wlroots/backend/session)

(defcfun "wlr_session_create" (:pointer (:struct wlr_session))
  "Opens a session, taking control of the current virtual terminal.
This should not be called if another program is already in control
of the terminal (Xorg, another Wayland compositor, etc.).

If logind support is not enabled, you must have CAP_SYS_ADMIN or
be root.
It is safe to drop privileges after this is called.

Returns NULL on error."
  (disp :pointer))

(defcfun "wlr_session_destroy" :void
  "Closes a previously opened session and restores the virtual
terminal.
You should call wlr_session_close_file on each files you opened
with wlr_session_open_file before you call this."
  (session (:pointer (:struct wlr_session))))

(defcfun "wlr_session_open_file" :int
  "Opens the file at path.
 This can only be used to open DRM or evdev (input) devices.

 When the session becomes inactive:
 - DRM files lose their DRM master status
 - evdev files become invalid and should be closed

 Returns -errno on error."
  (session (:pointer (:struct wlr_session)))
  (path :string))

(defcfun "wlr_session_close_file" :void
  (session (:pointer (:struct wlr_session)))
  (fd :int))

(defcfun wlr_session_signal_add :void
  (session (:pointer (:struct wlr_session)))
  (fd :int)
  (listener :pointer))

(defcfun "wlr_session_change_vt" :bool
  "Changes the virtual terminal."
  (session (:pointer (:struct wlr_session)))
  (vt :unsigned-int))

;; size_t (struct wlr_session *session,
;;         size_t ret_len, int *ret);
;; TODO: find out how to get size_t for cffi:
;; (defcfun "wlr_session_find_gpus"
