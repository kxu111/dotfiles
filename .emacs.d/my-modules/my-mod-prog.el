(my-emacs-configure
  ;; Display line numbers
  (setq display-line-numbers-width 3)
  (add-hook 'prog-mode-hook #'display-line-numbers-mode)

  (add-hook 'prog-mode-hook #'hl-line-mode)
  )

(my-emacs-configure
 (use-package eglot
   :bind
   (:map eglot-mode-map
         ("C-c l a" . eglot-code-actions)
         ("C-c l r" . eglot-rename)
         ("C-c l f" . eglot-format))))

(my-emacs-configure
  ;; c++ mode is built in
  (add-hook 'c++-mode-hook #'eglot-ensure))

(my-emacs-configure
 (use-package nix-mode :defer t)
 (add-hook 'nix-mode-hook #'eglot-ensure))

(my-emacs-configure
  (use-package haskell-mode)
  (add-hook 'haskell-mode-hook #'eglot-ensure))

(provide 'my-mod-prog)
