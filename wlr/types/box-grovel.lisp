(in-package #:wlr/types/box)
(pkg-config-cflags "wlroots")
(cc-flags "-DWLR_USE_UNSTABLE")
(include "wlr/types/wlr_box.h")

(cstruct box "struct wlr_box"
	 (x "x" :type :int)
	 (y "y" :type :int)
	 (width "width" :type :int)
	 (height "height" :type :int))
