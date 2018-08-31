(in-package #:cl-wlroots/types/data-device)

;; (defcvar ("wlr_data_device_pointer_drag_interface"
;; 	  data-device-pointer-drag-interface))

(export '(data-device-manager
	  data-device-manager-create
	  data-source
	  data-offer
	  data-source-impl
	  drag-icon
	  drag
	  drag-motion-event))

(defcfun ("wlr_data_device_manager_create" data-device-manager-create)
    (:pointer (:struct data-device-manager))
  (display :pointer))
