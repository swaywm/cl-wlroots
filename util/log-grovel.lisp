(in-package #:cl-wlroots/log)
(include "wlr/util/log.h")
(cenum log-level
       ((:log-silent "WLR_SILENT"))
       ((:log-error "WLR_ERROR"))
       ((:log-info "WLR_INFO"))
       ((:log-debug "WLR_DEBUG"))
       ((:log-importance-last "WLR_LOG_IMPORTANCE_LAST")))
