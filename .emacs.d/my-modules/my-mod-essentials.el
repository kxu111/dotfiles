(my-emacs-configure
   (delete-selection-mode t))

(my-emacs-configure
  (global-auto-revert-mode 1)
  (setq auto-revert-verbose t))

(my-emacs-configure
 (setq which-key-separator "  "
       which-key-prefix-prefix "... "
       which-key-max-display-columns 3
       which-key-idle-delay 1.5
       which-key-idle-secondary-delay 0.25
       which-key-add-column-padding 1
       which-key-max-description-length 40)

 (which-key-mode 1))

(my-emacs-configure
  (add-hook 'before-save-hook #'delete-trailing-whitespace))

(my-emacs-configure
  (define-key my-bind-overrides-mode-map
              (kbd "C-,")
              (lambda ()
		(interactive)
		(duplicate-line)
		(next-line))))

(setq display-time-string-forms '((concat " " (format-time-string "%a %d %b, %H:%M"))))
(display-time-mode t)

(define-key global-map (kbd "M-o") #'other-window)

(use-package exec-path-from-shell)
(when (memq window-system '(mac ns x pgtk))
  (exec-path-from-shell-initialize))

(setq truncate-lines t)

(my-emacs-configure
  (add-hook 'text-mode #'variable-pitch-mode))

(my-emacs-configure
  ;; Emacs 29 to hide bookmark fringe icon
  (setq bookmark-fringe-mark nil)
  ;; Write changes to the bookmark file as soon as modification is made.
  ;; Otherwise Emacs will only save the bookmarks when it closes.
  (setq bookmark-save-flag 1))

(provide 'my-mod-essentials)
