(in-package #:cl-wlroots/backend/session)

(export '(session
	  device
	  session-create
	  session-destroy
	  session-open-file
	  session-close-file
	  session-signal-add
	  session-change-vt
	  session-find-gpus))

(defcfun ("wlr_session_create" session-create) (:pointer (:struct session))
  "Opens a session, taking control of the current virtual terminal.
This should not be called if another program is already in control
of the terminal (Xorg, another Wayland compositor, etc.).

If logind support is not enabled, you must have CAP_SYS_ADMIN or
be root.
It is safe to drop privileges after this is called.

Returns NULL on error."
  (disp :pointer))

(defcfun ("wlr_session_destroy" session-destroy) :void
  "Closes a previously opened session and restores the virtual
terminal.
You should call wlr_session_close_file on each files you opened
with wlr_session_open_file before you call this."
  (session (:pointer (:struct session))))

(defcfun ("wlr_session_open_file" session-open-file) :int
  "Opens the file at path.
 This can only be used to open DRM or evdev (input) devices.

 When the session becomes inactive:
 - DRM files lose their DRM master status
 - evdev files become invalid and should be closed

 Returns -errno on error."
  (session (:pointer (:struct session)))
  (path :string))

(defcfun ("wlr_session_close_file" session-close-file) :void
  (session (:pointer (:struct session)))
  (fd :int))

(defcfun ("wlr_session_signal_add" session-signal-add) :void
  (session (:pointer (:struct session)))
  (fd :int)
  (listener :pointer))

(defcfun ("wlr_session_change_vt" session-change-vt) :bool
  "Changes the virtual terminal."
  (session (:pointer (:struct session)))
  (vt :unsigned-int))

(defcfun ("wlr_session_find_gpus" session-find-gpus) size-t
  (ret-len size-t)
  (ret (:pointer :int)))
