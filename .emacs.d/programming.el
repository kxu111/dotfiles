(use-package nix-mode :defer t)

(use-package simpc-mode
  :straight (simpc-mode :host github :repo "rexim/simpc-mode")
  :mode "\\.[hc]\\(pp\\)?\\'"
  :config (simpc-mode))
