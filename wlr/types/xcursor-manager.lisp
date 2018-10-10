(in-package #:wlr/types/xcursor-manager)

(export '(xcursor-manager
	  xcursor-manager-create
	  xcursor-manager-destroy
	  xcursor-manager-get-xcursor
	  xcursor-manager-load
	  xcursor-manager-set-cursor-image
	  xcursor-manager-theme))

(defcfun "wlr_xcursor_manager_create" (:pointer (:struct xcursor-manager))
  (name :string)
  (size :uint32))

(def-initialization xcursor-manager-create (name size)
  'xcursor-manager wlr-xcursor-manager-create
  "Creates a new XCursor manager with the given xcursor
theme name and base size (for use when scale=1).")

(defcfun ("wlr_xcursor_manager_destroy" xcursor-manager-destroy)
    :void
  (manager (:pointer (:struct xcursor-manager))))

(defcfun ("wlr_xcursor_manager_load" xcursor-manager-load)
    :int
  "Ensures an xcursor theme at the given scale factor
is loaded in the manager."
  (manager (:pointer (:struct xcursor-manager)))
  (scale :float))

(defcfun ("wlr_xcursor_manager_get_xcursor" xcursor-manager-get-xcursor)
    (:pointer (:struct xcursor))
  "Retrieves a wlr_xcursor reference for the given cursor name at
the given scale factor, or NULL if this wlr_xcursor_manager
has not loaded a cursor theme at the requested scale."
  (manager (:pointer (:struct xcursor-manager)))
  (name :string)
  (scale :float))

(defcfun ("wlr_xcursor_manager_set_cursor_image"
	  xcursor-manager-set-cursor-image)
    :void
  (manager (:pointer (:struct xcursor-manager)))
  (name :string)
  (cursor (:pointer (:struct cursor))))
