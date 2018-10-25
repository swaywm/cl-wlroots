(in-package :wlr/render/renderer)

(export '(renderer
	  renderer-autocreate
	  renderer-begin
	  renderer-end
	  renderer-clear
	  renderer-scissor
	  render-texture
	  render-texture-with-matrix
	  render-quad-with-matrix
	  render-rectangle
	  renderer-init-wl-display))

(defcfun ("wlr_renderer_autocreate" renderer-autocreate) (:pointer (:struct renderer))
  ;; (egl (:pointer (:struct egl)))
  (platform egl::eglenum)
  (remote-display (:pointer :void))
  (config_attribs (:pointer egl:EGLint)))

(defcfun ("wlr_renderer_begin" renderer-begin) :void
  (renderer (:pointer (:struct renderer)))
  (width :int)
  (height :int))

(defcfun ("wlr_renderer_end" renderer-end) :void
  (renderer (:pointer (:struct renderer))))

(defcfun ("wlr_renderer_clear" internal-renderer-clear) :void
  (renderer (:pointer (:struct renderer)))
  (color :pointer))

(declaim (inline renderer-clear))
(defun renderer-clear (renderer color-array)
  (with-foreign-array (color color-array '(:array :float 4))
    (internal-renderer-clear renderer color)))

(defcfun ("wlr_renderer_scissor" renderer-scissor) :void
  "Defines a scissor box. Only pixels that lie within the scissor box can be
modified by drawing functions. Providing a NULL `box` disables the scissor
box."
  (renderer (:pointer (:struct renderer)))
  (box box))

;; These funtions need to have wlr_texture to be ported over.

(defcfun ("wlr_render_texture" render-texture) :bool
  (r (:pointer (:struct renderer)))
  ;; (texture (:pointer (:struct texture)))
  (texture :pointer)
  (projection :pointer)
  (x :int)
  (y :int)
  (alpha :float))

(defcfun ("wlr_render_texture_with_matrix"  render-texture-with-matrix) :bool
  "Renders the requested texture using the provided matrix."
   (r (:pointer (:struct renderer)))
   ;; (texture (:pointer (:struct texture)))
   (texture :pointer)
   (matrix :pointer)
   (aplha :float))

(defcfun ("wlr_render_rect" render-rectangle) :void
  "Renders a solid rectangle in the specified color."
  (r (:pointer (:struct renderer)))
  (box box)
  (color :pointer)
  (projection :pointer))

(defcfun ("wlr_render_quad_with_matrix" render-quad-with-matrix) :void
  "Renders a solid quadrangle in the specified color with the specified matrix."
  (r (:pointer (:struct renderer)))
  (color :pointer)
  (matrix :pointer))

(defcfun ("wlr_renderer_init_wl_display" renderer-init-wl-display) :void
  (renderer (:pointer (:struct renderer)))
  (display :pointer))
