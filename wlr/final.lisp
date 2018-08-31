(uiop:define-package #:wlr
  (:use-reexport
   #:cl-wlroots/backend/session
   #:cl-wlroots/backend
   #:cl-wlroots/util/log
   #:cl-wlroots/types/seat
   #:cl-wlroots/types/output-layout
   #:cl-wlroots/types/output
   #:cl-wlroots/types/data-device
   #:cl-wlroots/types/output-damage
   #:cl-wlroots/render/renderer))
