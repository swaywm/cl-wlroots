(in-package :wlr/xcursor)
(include "wlr/xcursor.h")

(cstruct xcursor-image "struct wlr_xcursor_image"
	 (:width "width" :type :uint32)
	 (:height "height" :type :uint32)
	 (:hotspot-x "hotspot_x" :type :uint32)
	 (:hotspot-y "hotspot_y" :type :uint32)
	 (:delay "delay" :type :uint32)
	 (:buffer "buffer" :type :uint8))

(cstruct xcursor "struct wlr_xcursor"
	 (:image-count "image_count" :type :uint)
	 (:images "images" :type (:pointer
				  (:pointer (:struct xcursor-image))))
	 (:name "name" :type :string)
	 (:total-delay "total_delay" :type :uint32))

;; container for an xcusor theme:
(cstruct xcursor-theme "struct wlr_xcursor_theme"
	 (:cursor-count "cursor_count" :type :uint)
	 (:cursors "cursors" :type (:pointer
				    (:pointer (:struct xcursor))))
	 (:name "name" :type :string)
	 (:size "size" :type :int))
