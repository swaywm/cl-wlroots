(in-package #:cl-wlroots/util/log)

(export '(log-init log-level))

(defcfun "wlr_log_init" :void
  (verbosity log-level)
  (callback :pointer))

(defun log-init (log-level &optional (callback (cffi:null-pointer)))
  "Set the wlroots log level to different values.
Optons are :log-debug, :log-error, :log-info, :log-silent :log-importance-last.
The callback provided allows the logs to be redirected and is the form (importance fmt-string args).
fmt-string is a c-styled format string."
  (wlr-log-init (foreign-enum-value 'log-level log-level) callback))

(declaim (inline log-init))
