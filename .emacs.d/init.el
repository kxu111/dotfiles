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

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta
        mac-option-modifier nil
        mac-right-command-modifier 'super)
  (when (display-graphic-p) (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t)))
  (setq frame-resize-pixelwise t)
  (add-hook 'window-setup-hook 'toggle-frame-maximized t))

(set-face-font 'default "Aporetic Sans Mono 20")
(set-face-font 'fixed-pitch "Aporetic Sans Mono 20")
(set-face-font 'variable-pitch "Aporetic Sans 20")

(setq
 use-short-answers t
 ring-bell-function 'ignore
 inhibit-startup-message t
 vc-follow-symlinks t
 custom-safe-themes t)

(setq-default
 indent-tabs-mode nil
 tab-width 4)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode -1)

(delete-selection-mode t) ; Typing while a selection is active automatically replaces it with what you typed.
(global-auto-revert-mode t) ; Emacs refreshes a file once it changes on disk.
(savehist-mode t) ; Save minibuffer history.
(which-key-mode t)

(defvar my-overrides-mode-map (make-sparse-keymap)
  "Keymap for `my-overrides-mode'.")

(define-minor-mode my-overrides-mode
  "Activate `my-overrides-mode-map'."
  :global t
  :init-value nil
  :keymap my-overrides-mode-map)

(define-key my-overrides-mode-map
            (kbd "C-,")
            (lambda ()
              (interactive)
              (duplicate-line)
              (next-line)))

(my-overrides-mode t) ; I just re-enable this every time I define a keybind

(add-hook 'before-save-hook 'delete-trailing-whitespace)

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

;; These blocks check if Emacs can display a sufficient amount of colors, and then checks if the theme is light or dark
(defface my-icons-red
  '((((class color) (min-colors 88) (background light)) :foreground "#aa3232")
    (((class color) (min-colors 88) (background dark)) :foreground "#f06464")
    (t :foreground "red"))
  "Use for red-colored icons")

(defface my-icons-gray
  '((t :inherit (bold shadow)))
  "Use for gray-colored icons.")

(defvar my-modeline-read-only
  '(:eval
    (when buffer-read-only
      (propertize
       " "
       'face (if (mode-line-window-selected-p)
                 'my-icons-red
               'my-icons-gray)))))

(defvar my-modeline-buffer-name
  '(:eval
    (propertize (buffer-name) 'face
                (if (buffer-modified-p)
                    '(:weight bold :slant italic) 'bold))))

(defvar my-modeline-major-mode
  '(:eval
    (format "%s %s"
            (propertize (my-mode-line-icon) 'face 'my-icons-gray)
            (capitalize (string-replace "-mode" "" (symbol-name major-mode))))))

(defvar my-modeline-vc
  '(:eval
    (unless (not vc-mode)
      (let ((s (substring-no-properties vc-mode 5)))
        (concat
         (propertize "⇅ " 'face 'my-icons-gray)
         (if (eq (vc-state buffer-file-name) 'up-to-date)
             s (propertize s 'face 'italic)))))))

(defvar my-modeline-multiple-cursors
  '(:eval
    (when (and (mode-line-window-selected-p)
               (bound-and-true-p multiple-cursors-mode))
      mc/mode-line)))

(defvar my-modeline-position
  '(:eval
    (when (mode-line-window-selected-p)
      (format-mode-line "%6l:%c (%%p)"))))

(setq display-time-string-forms '((format-time-string "%a %d %b, %H:%M")))
(display-time-mode t)
(defvar my-modeline-misc-info
  '(:eval
    (when (mode-line-window-selected-p)
      (format-mode-line mode-line-misc-info))))

(setq-default mode-line-format
              (list
               "  %e"
               my-modeline-read-only
               my-modeline-buffer-name
               "  "
               my-modeline-major-mode
               'mode-line-process
               "  "
               my-modeline-vc
               'mode-line-format-right-align
               my-modeline-multiple-cursors
               my-modeline-position
               "  "
               my-modeline-misc-info
               "  "))

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x pgtk))
    (exec-path-from-shell-initialize)))

(use-package doric-themes)
(load-theme 'doric-dark t)

(use-package magit)

(use-package multiple-cursors
  :custom
  (mc/always-run-for-all t)
  :config
  (define-key my-overrides-mode-map (kbd "C-M-j") #'mc/mark-all-dwim)
  (define-key my-overrides-mode-map (kbd "C-M-/") #'mc/mark-all-like-this)

  (define-key my-overrides-mode-map (kbd "C-M-,") #'mc/mark-previous-like-this)
  (define-key my-overrides-mode-map (kbd "C-M-.") #'mc/mark-next-like-this)

  (define-key my-overrides-mode-map (kbd "C-<") #'mc/skip-to-previous-like-this)
  (define-key my-overrides-mode-map (kbd "C->") #'mc/skip-to-next-like-this)

  (define-key my-overrides-mode-map (kbd "C-M-c") #'mc/edit-lines)
  (define-key my-overrides-mode-map (kbd "C-M-n") #'mc/insert-numbers)
  (define-key my-overrides-mode-map (kbd "C-M-'") #'mc-hide-unmatched-lines-mode))

(use-package expreg
  :config
  (define-key my-overrides-mode-map (kbd "C-M-l") #'expreg-expand)
  (define-key my-overrides-mode-map (kbd "C-M-h") #'expreg-contract))

(use-package move-text
  :config
  (define-key my-overrides-mode-map (kbd "M-p") #'move-text-up)
  (define-key my-overrides-mode-map (kbd "M-n") #'move-text-down))

(my-overrides-mode t)

(use-package org
  :straight (:host github :repo "bzg/org-mode" :branch "main")
  :hook (org-mode . visual-line-mode)
  :custom
  (org-use-speed-commands t)
  (org-startup-indented t)
  (org-hide-emphasis-markers t)
  (org-cycle-separator-lines 1) ; Keep a line between folded headings
  (org-src-content-indentation 0)
  :config
  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (shell . t))))

 (use-package org-appear
   :straight (:type git :host github :repo "awth13/org-appear")
   :custom (org-appear-autolinks t)
   :hook (org-mode . org-appear-mode))

 (use-package org-roam
   :bind
   ("C-c n c" . org-roam-capture)
   ("C-c n f" . org-roam-node-find)
   ("C-c n i" . org-roam-node-insert)
   :custom (org-capture-bookmark nil)
   :config (org-roam-db-autosync-mode t))

 (use-package org-roam-ui :commands org-roam-ui-mode)

(use-package vertico
  :config
  (vertico-mode)
  (vertico-multiform-mode)
  :custom
  (vertico-multiform-commands ; Customize display per-command
   '((execute-extended-command flat)))
  (vertico-resize t)
  (vertico-count 12))

(use-package consult
  :bind
  ("M-s M-g" . consult-ripgrep)
  ("M-s M-f" . find-file)
  ("M-s M-d" . consult-fd) ; Mnemonic: Search Directory
  ("M-s M-o" . consult-outline)
  ("M-s M-l" . consult-line)
  ("M-s M-b" . consult-buffer)
  ("M-s M-k" . kill-buffer)

  :config
  (setq consult-ripgrep-args "rg --null --line-buffered --color=never --max-columns=1000 --path-separator / --smart-case --no-heading --with-filename --line-number --search-zip --hidden"
        consult-fd-args "fd --full-path --color=never --hidden")

  ;; Don't display these buffers
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

(use-package corfu
  :custom
  (corfu-count 6)
  (corfu-auto-prefix 2)
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode)
  :hook (prog-mode . (lambda () (setq-local corfu-auto t)))
  :bind (:map corfu-map ("M-SPC" . corfu-insert-separator)))

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

(use-package golden-ratio
  :config
  (golden-ratio-mode t)
  (add-to-list 'golden-ratio-extra-commands 'ace-window))

(use-package ace-window :config (define-key my-overrides-mode-map (kbd "M-o") #'ace-window))

(my-overrides-mode t)

(use-package elfeed
  :bind ("C-x f" . elfeed)
  :hook (elfeed-show-mode . visual-line-mode)
  :custom (elfeed-search-filter "@6months +unread -junk"))

(use-package elfeed-org
  :after elfeed
  :config (elfeed-org)
  :custom (rmh-elfeed-org-files (list "~/.emacs.d/Emacs.org")))

(use-package elfeed-tube
  :after elfeed
  :bind
  (:map elfeed-show-mode-map
        ("F" . elfeed-tube-fetch)
        ([remap save-buffer] . elfeed-tube-save))
  (:map elfeed-search-mode-map
        ("F" . elfeed-tube-fetch)
        ([remap save-buffer] . elfeed-tube-save))
  :config
  (elfeed-tube-setup)
  (add-hook 'elfeed-new-entry-hook
            (elfeed-make-tagger :entry-link "https://www\\.youtube\\.com/shorts/.*"
                                :add 'junk
                                :remove 'unread)))

(use-package mpv)

(use-package elfeed-tube-mpv
  :after elfeed
  :bind
  (:map elfeed-show-mode-map
        ("<return>" . elfeed-tube-mpv)
        ("C-c C-f" . elfeed-tube-mpv-follow-mode)
        ("C-c C-w" . elfeed-tube-mpv-where)))

(let ((straight-current-profile 'programming)
    (f (expand-file-name "programming.el" user-emacs-directory)))
(when (file-exists-p f) (load f)))
