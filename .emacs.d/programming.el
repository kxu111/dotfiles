(use-package eglot
  :bind (:map eglot-mode-map
              ("C-c l a" . eglot-code-actions)
              ("C-c l r" . eglot-rename)
              ("C-c l f" . eglot-format))

  :hook ((c++-mode . eglot-ensure)
         (nix-mode . eglot-ensure)
         (python-mode . eglot-ensure)))

(use-package nix-mode :defer t)
