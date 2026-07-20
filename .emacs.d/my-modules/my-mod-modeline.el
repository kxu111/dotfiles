(require 'my-lib-modeline)

(setq display-time-string-forms '((format-time-string "%a %d %b, %H:%M")))
(display-time-mode t)

(setq-default mode-line-format
              (list
               "  %e"
               my-modeline-read-only
               my-modeline-buffer-name
               "  "
               my-modeline-major-mode
               'mode-line-process
               "  "
               my-modeline-vc
               'mode-line-format-right-align
               my-modeline-multiple-cursors
               my-modeline-position
               "  "
               my-modeline-misc-info
               "  "))

(provide 'my-mod-modeline)
