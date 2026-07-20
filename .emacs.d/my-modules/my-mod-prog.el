(my-emacs-configure
 (use-package eglot
   :bind
   (:map eglot-mode-map
         ("C-c l a" . eglot-code-actions)
         ("C-c l r" . eglot-rename)
         ("C-c l f" . eglot-format))))

;; c++ mode is built in
(add-hook 'c++-mode #'eglot-ensure)

(my-emacs-configure
 (use-package nix-mode :defer t)
 (add-hook nix-mode-hook . eglot-ensure))

(provide 'my-mod-prog)
