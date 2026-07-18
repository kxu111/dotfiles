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

;; basic emacs config. remember to press `C-h' for help!!
(use-package emacs
  :init
  (set-face-font 'default "Aporetic Sans Mono 20")
  (set-face-font 'fixed-pitch "Aporetic Sans Mono 20")
  (set-face-font 'variable-pitch "Aporetic Sans 20")

  (setq use-short-answers t
        ring-bell-function 'ignore
        inhibit-startup-message t
        vc-follow-symlinks t
        custom-safe-themes t
        mac-command-modifier 'meta
        mac-option-modifier nil
        mac-right-command-modifier 'super)

  :config
  ;; mac windowing fixes
  (when (and (eq system-type 'darwin)
             (display-graphic-p))
    (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
    (setq frame-resize-pixelwise t)
    (add-hook 'window-setup-hook 'toggle-frame-maximized t))

  (setq-default display-line-numbers-width 3
                indent-tabs-mode nil
                truncate-lines t ; disable line wrap
                tab-width 4)

  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (tooltip-mode -1)
  (menu-bar-mode -1)
  (blink-cursor-mode -1)
  (column-number-mode t)
  (delete-selection-mode t)
  (savehist-mode t)
  (global-auto-revert-mode t)
  (auto-save-visited-mode t)
  (which-key-mode t)
  (setq display-time-string-forms '((format-time-string "%a %d %b, %H:%M")))
  (display-time-mode t)

  ;;; --- begin modeline ---
  (defvar my-mode-icons
    '((dired-mode   "")
      (archive-mode "🮯")
      (diff-mode    "⇄")
      (prog-mode    "λ")
      (conf-mode    "")
      (text-mode    "¶")
      (comint-mode  "⨠")
      (t            "·")))

  (defun my-mode-line-icon ()
    (or
     (cadr (assq major-mode my-mode-icons))
     (catch 'icon
       (dolist (entry my-mode-icons)
         (when (and (not (eq (car entry) t)) (derived-mode-p (car entry)))
           (throw 'icon (cadr entry)))))
     (cadr (assq t my-mode-icons))))

  ;; checks if emacs has >= 88 colors && if bg is light or dark
  (defface my-icons-red
    '((((class color) (min-colors 88) (background light)) :foreground "#aa3232")
      (((class color) (min-colors 88) (background dark)) :foreground "#f06464")
      (t :foreground "red"))
    "use for red-colored icons")

  (defface my-icons-gray
    '((((class color) (min-colors 88) (background light)) :foreground "gray30")
      (((class color) (min-colors 88) (background dark)) :foreground "gray70")
      (t :foreground "gray"))
    "use for gray-colored icons.")

  (setq-default mode-line-format '("  "
                                   (:eval (when buffer-read-only (propertize " " 'face '(my-icons-red))))
                                   (:eval (propertize (buffer-name) 'face (if (buffer-modified-p) '(:weight bold :slant italic) 'bold)))
                                   "  " (:eval (format "%s %s" (propertize (my-mode-line-icon) 'face '(my-icons-gray)) (capitalize (string-replace "-mode" "" (symbol-name major-mode)))))
                                   mode-line-process
                                   "  " (:eval (unless (not vc-mode) (let ((s (substring-no-properties vc-mode 5))) (concat (propertize "⇅ " 'face '(my-icons-gray)) (if (eq (vc-state buffer-file-name) 'up-to-date) s (propertize s 'face 'italic))))))
                                   mode-line-format-right-align
                                   (:eval (when (bound-and-true-p multiple-cursors-mode) mc/mode-line))
                                   "%6l:%c (%o)"
                                   "  " mode-line-misc-info "  "))
  ;;; --- end modeline ---

  :bind
  ("C-," . (lambda ()
             (interactive)
             (duplicate-line)
             (next-line)))

  :hook
  (prog-mode . (lambda () (add-hook 'before-save-hook #'delete-trailing-whitespace nil t))))

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x pgtk))
    (exec-path-from-shell-initialize)))

(let ((straight-current-profile 'programming) ; load this first so it doesn't override my other binds
	  (f (expand-file-name "programming.el" user-emacs-directory)))
  (when (file-exists-p f) (load f)))

;;; actual packages
(use-package doric-themes)
(load-theme 'doric-dark t) ; great theme. love the frequent use of bold and italics

(use-package magit)

(use-package multiple-cursors
  :custom (mc/always-run-for-all t)
  :bind
  ("C-M-j" . mc/mark-all-dwim)
  ("C-M-/" . mc/mark-all-like-this)

  ("C-M-," . mc/mark-previous-like-this)
  ("C-M-." . mc/mark-next-like-this)

  ("C-<" . mc/skip-to-previous-like-this)
  ("C->" . mc/skip-to-next-like-this)

  ("C-M-c" . mc/edit-lines)
  ("C-M-n" . mc/insert-numbers)
  ("C-M-'" . mc-hide-unmatched-lines-mode))

(use-package expreg
  :bind
  ("C-M-l" . expreg-expand)
  ("C-M-h" . expreg-contract))

(use-package move-text
  :bind
  ("M-p" . move-text-up)
  ("M-n" . move-text-down))

;;; --- start org-mode ---
(use-package org
  :defer t
  :straight (:host github :repo "bzg/org-mode" :branch "main")
  :hook (org-mode . visual-line-mode)
  :custom
  (org-ellipsis "…")
  (org-use-speed-commands t)
  (org-startup-indented t)
  (org-hide-emphasis-markers t)
  (org-cycle-separator-lines 1) ; keep a line between collapsed headings
  )

(use-package org-appear
  :defer t
  :straight (:type git :host github :repo "awth13/org-appear")
  :custom (org-appear-autolinks t)
  :hook (org-mode . org-appear-mode))

(use-package org-roam
  :defer t
  :bind
  ("C-c n c" . org-roam-capture)
  ("C-c n f" . org-roam-node-find)
  ("C-c n i" . org-roam-node-insert)
  :custom (org-capture-bookmark nil)
  :config (org-roam-db-autosync-mode t))

(use-package org-roam-ui :commands org-roam-ui-mode) ; command implies defer until this is run
;;; --- end org-mode ---

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
  :bind
  ("M-s M-g" . consult-ripgrep)
  ("M-s M-f" . find-file)
  ("M-s M-d" . consult-fd) ; mnemonic: search directory
  ("M-s M-o" . consult-outline)
  ("M-s M-l" . consult-line)
  ("M-s M-b" . consult-buffer)
  ("M-s M-k" . kill-buffer)

  :config
  (setq consult-ripgrep-args "rg --null --line-buffered --color=never --max-columns=1000 --path-separator / --smart-case --no-heading --with-filename --line-number --search-zip --hidden"
        consult-fd-args "fd --full-path --color=never --hidden")

  ;; don't display these buffers
  (let ((buffers '("*Async-native-compile-log*" "*straight-process*" "*straight-byte-compilation*" "*direnv*" "*Messages*" "*Help*" "*Backtrace*" "*Warnings*" "*Native-compile-Log" "*elfeed-tube-log*")))
    (dolist (buf buffers) (add-to-list 'consult-buffer-filter (regexp-quote buf))))
  (add-to-list 'consult-buffer-filter "\\*EGLOT.*\\*")
  (add-to-list 'consult-buffer-filter "magit.*:"))

(use-package marginalia :config (marginalia-mode))

(use-package orderless :config (setq completion-styles '(orderless basic)))

(use-package embark
  :bind
  ("C-." . embark-act)
  (:map minibuffer-local-map
        ("C-c C-c" . embark-collect)
        ("C-c C-e" . embark-export)))

(use-package embark-consult)
;;; --- end minibuffer ---

(use-package corfu
  :custom
  (corfu-count 6)
  (corfu-auto-prefix 2)
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode)
  :hook (prog-mode . (lambda () (setq-local corfu-auto t)))
  :bind (:map corfu-map ("M-SPC" . corfu-insert-separator)))

(use-package golden-ratio
  :config
  (golden-ratio-mode t)
  (add-to-list 'golden-ratio-extra-commands 'ace-window))

(use-package ace-window :bind ("M-o" . ace-window))

(use-package wgrep
  :bind
  (:map grep-mode-map
        ("e" . wgrep-change-to-wgrep-mode)
        ("C-x C-q" . wgrep-change-to-wgrep-mode)
        ("C-c C-c" . wgrep-finish-edit))
  (:map compilation-mode-map
        ("e" . wgrep-change-to-wgrep-mode)
        ("C-x C-q" . wgrep-change-to-wgrep-mode)
        ("C-c C-c" . wgrep-finish-edit)))

(use-package mpv)

;;; --- start elfeed ---
(use-package elfeed
  :bind ("C-x f" . elfeed)
  :hook (elfeed-show-mode . visual-line-mode))

(use-package elfeed-org
  :after elfeed
  :config (elfeed-org))

(use-package elfeed-tube
  :after elfeed
  :demand t
  :bind
  (:map elfeed-show-mode-map
        ("F" . elfeed-tube-fetch)
        ([remap save-buffer] . elfeed-tube-save))
  (:map elfeed-search-mode-map
        ("F" . elfeed-tube-fetch)
        ([remap save-buffer] . elfeed-tube-save))
  :config
  (elfeed-tube-setup))

(use-package elfeed-tube-mpv
  :after elfeed
  :bind
  (:map elfeed-show-mode-map
        ("<return>" . elfeed-tube-mpv)
        ("C-c C-f" . elfeed-tube-mpv-follow-mode)
        ("C-c C-w" . elfeed-tube-mpv-where)))
;;; --- end elfeed ---
