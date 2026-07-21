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

(my-emacs-configure
 (with-eval-after-load 'grep
   (define-key grep-mode-map (kbd "e") #'grep-change-to-wgrep-mode)))

(define-key global-map (kbd "M-o") #'other-window)

(provide 'my-mod-essentials)
