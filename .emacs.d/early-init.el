;; Disable `package' in favor of `straight'
(setq package-enable-at-startup nil)

;; Increase garbage collection threshold
(setq gc-cons-threshold 100000000)

;;; macos-related setups
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(setq frame-resize-pixelwise t)
(add-hook 'window-setup-hook 'toggle-frame-maximized t)
