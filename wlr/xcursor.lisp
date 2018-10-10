#|
 * Copyright © 2012 Intel Corporation
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice (including the
 * next paragraph) shall be included in all copies or substantial
 * portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
 * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
|#

(in-package :wlr/xcursor)

(export '(xcursor
	 xcursor-theme
	 xcursor-theme-destroy
	 xcursor-theme-get-cursor
	 xcursor-theme-load
	 xcursor-frame
	 xcursor-get-resize-name
	 xcursor-image))

(defcfun ("wlr_xcursor_theme_load" xcursor-theme-load)
    (:pointer xcursor-theme)
  "Loads the named xcursor theme at the given cursor size (in pixels). This is
useful if you need cursor images for your compositor to use when a
client-side cursors is not available or you wish to override client-side
cursors for a particular UI interaction (such as using a grab cursor when
moving a window around)."
  (name :string)
  (size :int))

(defcfun ("wlr_xcursor_theme_destroy" xcursor-theme-destroy)
    :void
  (theme (:pointer (:struct xcursor-theme))))

(defcfun ("wlr_xcursor_theme_get_cursor" xcursor-theme-get-cursor)
    :void
  (theme (:pointer (:struct xcursor-theme)))
  (name :string))

(defcfun ("wlr_xcursor_frame" xcursor-frame) :int
  "Returns the current frame number for an animated cursor give a monotonic time
reference."
  (cursor (:pointer (:struct xcursor)))
  (time :uint32))

(defcfun ("wlr_xcursor_get_resize_name" xcursor-get-resize-name) :string
  "Get the name of the resize cursor image for the given edges."
  (edges edges))
