(in-package #:wlr/common-c-types)

(export '(size-t
	  timespec
	  clock-get-time))

(defcfun ("clock_gettime" clock-get-time) :int
  (clock-id clock-id)
  (timespec (:pointer (:struct timespec))))
