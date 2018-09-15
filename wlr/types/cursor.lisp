(in-package #:cl-wlroots/types/cursor)

(export  '(cursor
	   cursor-absolute-to-layout-coords
	   cursor-attach-input-device
	   cursor-attach-output-layout
	   cursor-create
	   cursor-destroy
	   cursor-detach-input-device
	   cursor-map-input-to-output
	   cursor-map-input-to-region
	   cursor-map-to-output
	   cursor-map-to-region
	   cursor-move
	   cursor-set-image
	   cursor-set-surface
	   cursor-warp
	   cursor-warp-absolute))

(defcfun "wlr_cursor_create" (:pointer (:struct cursor)))

(def-initialization cursor-create () 'cursor wlr-cursor-create)

(defcfun ("wlr_cursor_destroy" cursor-destroy) :void
  (cursor (:pointer (:struct cursor))))

(defcfun ("wlr_cursor_warp" cursor-warp) :bool
  "Warp the cursor to the given x and y in layout coordinates. If x and y are
out of the layout boundaries or constraints, no warp will happen.

`dev` may be passed to respect device mapping constraints. If `dev` is NULL,
device mapping constraints will be ignored.

Returns true when the cursor warp was successful."
  (cursor (:pointer (:struct cursor)))
  (device (:pointer (:struct input-device)))
  (lx :double)
  (ly :double))

(defcfun ("wlr_cursor_absolute_to_layout_coords" cursor-absolute-to-layout-coords) :void
  "Convert absolute 0..1 coordinates to layout coordinates.

`dev` may be passed to respect device mapping constraints. If `dev` is NULL,
device mapping constraints will be ignored."
  (cursor (:pointer (:struct cursor)))
  (device (:pointer (:struct input-device)))
  (x :double)
  (y :double)
  (lx :double)
  (ly :double))

(defcfun ("wlr_cursor_warp_absolute" cursor-warp-absolute):void
  " * Warp the cursor to the given x and y in absolute 0..1 coordinates. If the
 * given point is out of the layout boundaries or constraints, the closest point
 * will be used. If one coordinate is NAN, it will be ignored.
 *
 * `dev` may be passed to respect device mapping constraints. If `dev` is NULL,
 * device mapping constraints will be ignored."
  (cursor (:pointer (:struct cursor)))
  (device (:pointer (:struct input-device)))
  (x :double)
  (y :double))

(defcfun ("wlr_cursor_move" cursor-move) :void
  " * Move the cursor in the direction of the given x and y layout coordinates. If
 * one coordinate is NAN, it will be ignored.
 *
 * `dev` may be passed to respect device mapping constraints. If `dev` is NULL,
 * device mapping constraints will be ignored."
  (cursor (:pointer (:struct cursor)))
  (device (:pointer (:struct input-device)))
  (delta-x :double)
  (delta-y :double))

(defcfun ("wlr_cursor_set_image" cursor-set-image) :void
  " * Set the cursor image. stride is given in bytes. If pixels is NULL, hides the
 * cursor.
 *
 * If scale isn't zero, the image is only set on outputs having the provided
 * scale."
  (cursor (:pointer (:struct cursor)))
  (pixels (:pointer :uint8))
  (stride :int32)
  (width :uint32)
  (height :uint32)
  (hotspot-x :int32)
  (hotspot-y :int32)
  (scale :float))

(defcfun ("wlr_cursor_set_surface" cursor-set-surface) :void
  " * Set the cursor surface. The surface can be committed to update the cursor
 * image. The surface position is subtracted from the hotspot. A NULL surface
 * commit hides the cursor."
  (cursor (:pointer (:struct cursor)))
  ;; TODO: pointer to wlr:surface
  (surface :pointer)
  (hotspot-x :int32)
  (hotspot-y :int32))


(defcfun ("wlr_cursor_attach_input_device" cursor-attach-input-device) :void
  " * Attaches this input device to this cursor. The input device must be one of:
 *
 * - WLR_INPUT_DEVICE_POINTER
 * - WLR_INPUT_DEVICE_TOUCH
 * - WLR_INPUT_DEVICE_TABLET_TOOL"
  (cursor (:pointer (:struct cursor)))
  (device (:pointer (:struct input-device))))

(defcfun ("wlr_cursor_detach_input_device" cursor-detach-input-device) :void
  (cursor (:pointer (:struct cursor)))
  (device (:pointer (:struct input-device))))

(defcfun ("wlr_cursor_attach_output_layout" cursor-attach-output-layout) :void
  " * Uses the given layout to establish the boundaries and movement semantics of
 * this cursor. Cursors without an output layout allow infinite movement in any
 * direction and do not support absolute input events."
  (cursor (:pointer (:struct cursor)))
  (layout (:pointer (:struct output-layout))))

(defcfun ("wlr_cursor_map_to_output" cursor-map-to-output) :void
  " * Attaches this cursor to the given output, which must be among the outputs in
 * the current output_layout for this cursor. This call is invalid for a cursor
 * without an associated output layout."
  (cursor (:pointer (:struct cursor)))
  (output (:pointer (:struct output))))

(defcfun ("wlr_cursor_map_input_to_output" cursor-map-input-to-output) :void
  " * Maps all input from a specific input device to a given output. The inputp
 * device must be attached to this cursor and the output must be among the
 * outputs in the attached output layout."
  (cursor (:pointer (:struct cursor)))
  (device (:pointer (:struct input-device)))
  (output (:pointer (:struct output))))

(defcfun ("wlr_cursor_map_to_region" cursor-map-to-region) :void
  "Maps this cursor to an arbitrary region on the associated wlr_output_layout."
  (cursor (:pointer (:struct cursor)))
  (box (:pointer (:struct box))))

(defcfun ("wlr_cursor_map_input_to_region" cursor-map-input-to-region) :void
  " * Maps inputs from this input device to an arbitrary region on the associated
 * wlr_output_layout."
  (cursor (:pointer (:struct cursor)))
  (device (:pointer (:struct input-device)))
  (box (:pointer (:struct box))))
