(in-package #:wlr/wlr-version)
(pkg-config-cflags "wlroots")
(include "wlr/version.h")

(constant (+wlr-version-major+ "WLR_VERSION_MAJOR") :type integer)
(constant (+wlr-version-minor+ "WLR_VERSION_MINOR") :type integer)
(constant (+wlr-version-micro+ "WLR_VERSION_MICRO") :type integer)

(constant (+wlr-version-num+  "WLR_VERSION_NUM") :type integer)

(constant (+wlr-version-api-current+ "WLR_VERSION_API_CURRENT") :type integer)
(constant (+wlr-version-api-revision+ "WLR_VERSION_API_REVISION") :type integer)
(constant (+wlr-version-api-age+ "WLR_VERSION_API_AGE") :type integer)
