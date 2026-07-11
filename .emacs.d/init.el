;; bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(use-package straight
  :custom
  (straight-use-package-by-default t)
  (straight-current-profile 'base)
  (straight-vc-git-default-protocol 'ssh)
  :config
  (setq straight-profiles
        `((base . "~/dotfiles/.emacs.d/straight.lockfile.base.el")
          (programming . "~/dotfiles/.emacs.d/straight.lockfile.programming.el"))))

;; basic emacs config. remember to press C-h for help!!
(use-package emacs
  :init
  (setq use-short-answers t
        ring-bell-function 'ignore
        inhibit-startup-message t
        vc-follow-symlinks t
        custom-safe-themes t
        compile-command ""
        mac-command-modifier 'meta
        mac-option-modifier nil
        mac-right-command-modifier 'super)

  :config
  (set-face-font 'default "Aporetic Sans Mono 20")
  (set-face-font 'variable-pitch "Aporetic Sans")

  (setq-default display-line-numbers-width 3
                indent-tabs-mode nil
                tab-width 4)

  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (tooltip-mode -1)
  (menu-bar-mode -1)
  (blink-cursor-mode -1)
  (column-number-mode t)
  (delete-selection-mode t)
  (recentf-mode t)
  (savehist-mode t)
  (global-auto-revert-mode t)
  (auto-save-visited-mode t)

  (setq-default mode-line-format '(" -%*- "
                                   (:eval (propertize (buffer-name)) 'face 'font-lock-constant-face)
                                   "%6l:%c (%o) "
                                   (:eval (unless (not vc-mode) (concat " | ⇅ " (substring-no-properties vc-mode 5))))
                                   mode-line-format-right-align
                                   (:eval
                                    (when (bound-and-true-p multiple-cursors-mode)
                                      mc/mode-line))
                                   (:eval (concat "  " (symbol-name major-mode)))
                                   mode-line-process
                                   "  " mode-line-misc-info))

  :bind
  (("C-," . (lambda ()
              (interactive)
              (duplicate-line)
              (next-line)))

   ;; wrapper functions to center cursor after scrolling
   ("C-v" . (lambda ()
              (interactive)
              (scroll-up-command)
              (move-to-window-line nil)))
   ("M-v" . (lambda ()
              (interactive)
              (scroll-down-command)
              (move-to-window-line nil))))

  :hook
  ((before-save . delete-trailing-whitespace)
   (prog-mode . display-line-numbers-mode)))

;;; actual packages
(use-package doom-themes)
(load-theme 'doom-dark+)

(use-package magit)

(use-package multiple-cursors
  :bind (("C-M-j" . mc/mark-all-dwim)
         ("C-M-/" . mc/mark-all-like-this)

         ("C-M-," . mc/mark-previous-like-this)
         ("C-M-." . mc/mark-next-like-this)

         ("C-<" . mc/skip-to-previous-like-this)
         ("C->" . mc/skip-to-next-like-this)

         ("C-M-c" . mc/edit-lines)
         ("C-M-n" . mc/insert-numbers)
         ("C-M-'" . mc-hide-unmatched-lines-mode))

  :custom (mc/always-run-for-all t))

(use-package expreg
  :bind (("C-M-l" . expreg-expand)
         ("C-M-h" . expreg-contract)))

(use-package move-text
  :bind (("M-p" . move-text-up)
         ("M-n" . move-text-down)))

;;; --- start org-mode ---
(use-package org
  ;; pull from remote to get latest version
  :straight (:host github :repo "bzg/org-mode" :branch "main")
  :hook ((org-mode . visual-line-mode))
  :custom
  (org-ellipsis "…")
  (org-use-speed-commands t)
  (org-startup-indented t)
  (org-cycle-separator-lines 1) ; keep a line between collapsed headings
  (org-hide-emphasis-markers t) ; conceals formatting chars, e.g *bold*
  )

;; (use-package org-roam) ; TODO configure this

;; (use-package org-roam-ui) ; TODO configure this
;;; --- end org-mode ---

(let ((straight-current-profile 'programming)
	  (f (expand-file-name "programming.el" user-emacs-directory)))
  (when (file-exists-p f) (load f)))

;;; --- start minibuffer ---
(use-package vertico
  :config
  (vertico-mode)
  (vertico-multiform-mode)
  :custom
  (vertico-multiform-commands ; customize display per-command
   '((execute-extended-command flat)))
  (vertico-resize t)
  (vertico-count 12))

(use-package consult
  :bind (("M-s M-g" . consult-ripgrep)
         ("M-s M-f" . find-file)
         ("M-s M-d" . consult-fd) ;; mnemonic: search directory
         ("M-s M-o" . consult-outline)
         ("M-s M-l" . consult-line)
         ("M-s M-b" . consult-buffer))

  :config
  (setq (consult-ripgrep-args "rg --null --line-buffered --color=never --max-columns=1000
--path-separator / --smart-case --no-heading --with-filename
--line-number --search-zip --hidden")
        (consult-fd-args "fd --full-path --color=never --hidden"))
  (add-to-list 'consult-buffer-filter "\\`\\*.*\\*\\'") ; hide * buffers (e.g *scratch*)
  )

(use-package marginalia
  :config (marginalia-mode))

(use-package orderless
  :config (setq completion-styles '(orderless basic)))

(use-package embark
  :bind (("C-." . embark-act)
         :map minibuffer-local-map
         ("C-c C-c" . embark-collect)
         ("C-c C-e" . embark-export)))

(use-package embark-consult)
;;; --- end minibuffer ---

(use-package corfu
  :config
  (global-corfu-mode)
  (corfu-popupinfo-mode)
  :custom
  (corfu-auto t)
  (corfu-count 8)
  (corfu-auto-prefix 2))

;; (use-package corfu-terminal :hook (corfu-mode . corfu-terminal-mode))

(use-package golden-ratio
  :config
  (golden-ratio-mode t)
  (add-to-list 'golden-ratio-extra-commands 'ace-window))

(use-package ace-window
  :bind ("M-o" . ace-window))

;; give emacs access to shell commands when launched from GUI
(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x pgtk))
    (exec-path-from-shell-initialize)))

(use-package wgrep
  :bind ((:map grep-mode-map
               ("e" . wgrep-change-to-wgrep-mode)
               ("C-x C-q" . wgrep-change-to-wgrep-mode)
               ("C-C C-c" . wgrep-finish-edit))
         (:map compilation-mode-map
               ("e" . wgrep-change-to-wgrep-mode)
               ("C-x C-q" . wgrep-change-to-wgrep-mode)
               ("C-c C-c" . wgrep-finish-edit))))
