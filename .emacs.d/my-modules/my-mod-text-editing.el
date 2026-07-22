(my-emacs-configure
 (use-package multiple-cursors
   :custom
   (mc/always-run-for-all t)
   :config
   (define-key my-bind-overrides-mode-map (kbd "C-M-j") #'mc/mark-all-dwim)
   (define-key my-bind-overrides-mode-map (kbd "C-M-/") #'mc/mark-all-like-this)

   (define-key my-bind-overrides-mode-map (kbd "C-M-,") #'mc/mark-previous-like-this)
   (define-key my-bind-overrides-mode-map (kbd "C-M-.") #'mc/mark-next-like-this)

   (define-key my-bind-overrides-mode-map (kbd "C-<") #'mc/skip-to-previous-like-this)
   (define-key my-bind-overrides-mode-map (kbd "C->") #'mc/skip-to-next-like-this)

   (define-key my-bind-overrides-mode-map (kbd "C-M-c") #'mc/edit-lines)
   (define-key my-bind-overrides-mode-map (kbd "C-M-n") #'mc/insert-numbers)
   (define-key my-bind-overrides-mode-map (kbd "C-M-'") #'mc-hide-unmatched-lines-mode))

  (use-package expreg
    :config
    (define-key my-bind-overrides-mode-map (kbd "C-M-l") #'expreg-expand)
    (define-key my-bind-overrides-mode-map (kbd "C-M-h") #'expreg-contract)))

(my-emacs-configure
  (use-package move-text
    :config
    (define-key my-bind-overrides-mode-map (kbd "M-p") #'move-text-up)
    (define-key my-bind-overrides-mode-map (kbd "M-n") #'move-text-down)))

(use-package wgrep
  :bind ((:map grep-mode-map
               ("e" . wgrep-change-to-wgrep-mode)
               ("C-x C-q" . wgrep-change-to-wgrep-mode)
               ("C-c C-c" . wgrep-finish-edit))
         (:map compilation-mode-map
               ("e" . wgrep-change-to-wgrep-mode)
               ("C-x C-q" . wgrep-change-to-wgrep-mode)
               ("C-c C-c" . wgrep-finish-edit))))

(provide 'my-mod-text-editing)
