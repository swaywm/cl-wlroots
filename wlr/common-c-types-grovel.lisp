(in-package #:wlr/common-c-types)
(include "time.h")
(include "stddef.h")

(ctype size-t "size_t")

(cstruct timespec "struct timespec")

(cenum clock-id
       ((:monotonic "CLOCK_MONOTONIC")))
