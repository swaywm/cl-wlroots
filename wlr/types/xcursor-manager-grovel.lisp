(in-package #:wlr/types/xcursor-manager)
(include "wlr/types/wlr_xcursor_manager.h")

;; An XCursor theme at a particular scale factor of the base size.
(cstruct xcursor-manager-theme "struct wlr_xcursor_manager_theme"
	 (:scale "scale" :type :float)
	 (:theme "theme" :type (:pointer (:struct xcursor-theme)))
	 (:link "link" :type (:struct wl_list)))


;; wlr_xcursor_manager dynamically loads xcursor themes at sizes necessary for
;; use on outputs at arbitrary scale factors. You should call
;; wlr_xcursor_manager_load for each output you will show your cursor on, with
;; the scale factor parameter set to that output's scale factor.
(cstruct xcursor-manager "struct wlr_xcursor_manager"
	 (:name "name" :type :string)
	 (:size "size" :type :uint32)
	 (:scaled-themes "scaled_themes" :type (:struct wl_list)))
