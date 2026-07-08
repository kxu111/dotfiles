;;; setup use-package
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ;; ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;; basic emacs config. remember to press C-h for help!!
(use-package emacs
  :init
  (setq frame-resize-pixelwise t
        use-short-answers t
        ring-bell-function 'ignore
        inhibit-startup-message t
        custom-file (expand-file-name "custom.el" user-emacs-directory)
        vc-follow-symlinks t
        custom-safe-themes t
        whitespace-style (quote (face tabs spaces trailing space-before-tab newline indentation empty space-after-tab space-mark tab-mark))
        compile-command ""
        mac-command-modifier 'meta
        mac-option-modifier nil
        mac-right-command-modifier 'super)

  :config
  (set-face-font 'default "Iosevka 20")
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (setq-default display-line-numbers-width 3
                indent-tabs-mode nil
                tab-width 4)

  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (tooltip-mode -1)
  (menu-bar-mode -1)
  (blink-cursor-mode -1)
  (column-number-mode t)
  (fido-mode t)
  (delete-selection-mode t)
  (global-hl-line-mode t)
  (fringe-mode '(0 . 0))

  ;;; credit @JakeBox0 on YT
  (setq-default mode-line-format '(" %* "
                                   (:eval (propertize (buffer-name)) 'face 'font-lock-constant-face)
                                   "%6l:%c (%o) "
                                   (:eval (unless (not vc-mode) (concat " | ⇅ " (substring-no-properties vc-mode 5))))
                                   mode-line-format-right-align
                                   (:eval (concat "  " (symbol-name major-mode)))
                                   "  " mode-line-misc-info))

  :bind
  (("C-," . (lambda ()
              (interactive)
              (duplicate-line)
              (next-line))))

  :hook
  ((window-setup . toggle-frame-maximized)
   (prog-mode . display-line-numbers-mode)
   (prog-mode . (lambda ()
                  (add-hook 'before-save-hook 'delete-trailing-whitespace nil t)))))

(use-package doom-themes)
(load-theme 'doom-dark+ t)

(use-package magit)

(use-package nix-mode)

(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->"         . mc/mark-next-like-this)
         ("C-<"         . mc/mark-previous-like-this)
         ("C-c C-<"     . mc/mark-all-like-this)
         ("C-\""        . mc/skip-to-next-like-this)
         ("C-:"         . mc/skip-to-previous-like-this))
  :custom (mc/always-run-for-all t))

(use-package company
  :config (global-company-mode t))

(use-package move-text
  :bind (("M-p" . move-text-up)
         ("M-n" . move-text-down)))

(use-package centered-cursor-mode
  :config (global-centered-cursor-mode t))

(use-package simpc-mode
  :vc (:url "https://github.com/rexim/simpc-mode")
  :mode "\\.[hc]\\(pp\\)?\\'"
  :config (simpc-mode))

;;; orgmode
(use-package org
  :custom ((org-use-speed-commands t)
           (org-startup-indented t))
  :hook ((org-mode . visual-line-mode)))

(use-package org-bullets
  :hook ((org-mode . org-bullets-mode)))

(when (file-exists-p custom-file)
  (load custom-file))
