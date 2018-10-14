;; we could implement all of this in lisp in order to avoid
;; translating from lisp arrays to c arrays, but that is alot of uneccessary work.
;; Instead, we are just going to wrap the
;; see rtg-math for a common lisp graphics math library that is compatable with
;; opengl

(in-package :wlr/types/matrix)

(export '(matrix-identity
	  matrix-multiply
	  matrix-project-box
	  matrix-projection
	  matrix-rotate
	  matrix-scale
	  matrix-transform
	  matrix-transpose
	  matrix-translate))


(defcfun ("wlr_matrix_identity" matrix-identity) :void
  (to-mutate :pointer))

(defcfun ("wlr_matrix_multiply" matrix-multiply) :void
  (to-mutate :pointer)
  (a :pointer)
  (b :pointer))

(defcfun ("wlr_matrix_transpose" matrix-transpose) :void
  (to-mutate :pointer)
  (mat :pointer))

(defcfun ("wlr_matrix_translate" matrix-translate) :void
  (mat :pointer)
  (x :float)
  (y :float))

(defcfun ("wlr_matrix_scale" matrix-scale) :void
  (mat :pointer)
  (x :float)
  (y :float))

(defcfun ("wlr_matrix_rotate" matrix-rotate) :void
  (mat :pointer)
  (rad :float))

(defcfun ("wlr_matrix_transform" matrix-transform) :void
  (mat :pointer)
  (transform wl-output-transform))

(defcfun ("wlr_matrix_projection" matrix-projection) :void
  (mat :float)
  (width :int)
  (height :int)
  (transform wl-output-transform))

(defcfun ("wlr_matrix_project_box" matrix-project-box) :void
  (mat :pointer)
  (box box)
  (transform wl-output-transform)
  (rotation :float)
  (projection :pointer))
