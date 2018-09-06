(uiop:define-package :wlr
  (:use-reexport
   #:cl-wlroots/backend
   #:cl-wlroots/backend/session
   #:cl-wlroots/render/renderer
   #:cl-wlroots/types/box
   #:cl-wlroots/types/data-device
   #:cl-wlroots/types/output
   #:cl-wlroots/types/output-damage
   #:cl-wlroots/types/output-layout
   #:cl-wlroots/types/seat
   #:cl-wlroots/util/log))
