(my-emacs-configure
 (use-package golden-ratio
   :config
   (golden-ratio-mode t)
   (add-to-list 'golden-ratio-extra-commands 'ace-window))

 (use-package ace-window :config (define-key my-bind-overrides-mode-map (kbd "M-o") #'ace-window)))

(provide 'my-mod-split-windows)
