(my-emacs-configure
  (savehist-mode t))

(my-emacs-configure
  (use-package vertico
    :config (vertico-mode)
    :custom (vertico-resize t)))

;; straight.el specific
;; make backspace in find-file go up a full directory
(my-emacs-configure
  (use-package vertico-directory
    :after vertico
    :straight nil
    :load-path "straight/repos/vertico/extensions/"
    :bind ( :map vertico-map
            ("RET" . vertico-directory-enter)
            ("DEL" . vertico-directory-delete-char)
            ("M-DEL" . vertico-directory-delete-word))
    :hook (rfn-eshadow-update-overlay . vertico-directory-tidy)))

(my-emacs-configure
  (use-package consult
    :bind
    ("M-s M-g" . consult-ripgrep)
    ("M-s M-f" . find-file)
    ("M-s M-d" . consult-fd) ; Mnemonic: Search Directory
    ("M-s M-o" . consult-outline)
    ("M-s M-l" . consult-line)
    ("M-s M-b" . consult-buffer)
    ("M-s M-k" . kill-buffer)
    ("M-y" . consult-yank-pop)

    :config
    (setq consult-ripgrep-args "rg --null --line-buffered --color=never --max-columns=1000 --path-separator / --smart-case --no-heading --with-filename --line-number --search-zip --hidden")
    (setq consult-fd-args "fd --full-path --color=never --hidden")

    ;; Don't display these buffers
    (let ((buffers '("*Async-native-compile-log*" "*straight-process*" "*straight-byte-compilation*" "*direnv*" "*Messages*" "*Help*" "*Backtrace*" "*Warnings*" "*Native-compile-Log" "*elfeed-tube-log*")))
      (dolist (buf buffers) (add-to-list 'consult-buffer-filter (regexp-quote buf))))
    (add-to-list 'consult-buffer-filter "\\*EGLOT.*\\*")
    (add-to-list 'consult-buffer-filter "magit.*:")))

(my-emacs-configure
 (use-package marginalia :config (marginalia-mode))

 (use-package orderless :config (setq completion-styles '(orderless basic))))

(my-emacs-configure
  (use-package embark
    :bind
    ("C-." . embark-act)
    (:map minibuffer-local-map
          ("C-c C-c" . embark-collect)
          ("C-c C-e" . embark-export)))

  (use-package embark-consult))

(my-emacs-configure
 (use-package corfu
   :custom
   (corfu-count 6)
   (corfu-auto-prefix 2)
   :init
   (global-corfu-mode)
   (corfu-popupinfo-mode)
   :hook (prog-mode . (lambda () (setq-local corfu-auto t)))
   :bind (:map corfu-map ("M-SPC" . corfu-insert-separator))))

(provide 'my-mod-completions)
