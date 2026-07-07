(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode -1)
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(package-initialize)
(setq vc-follow-symlinks t)
(set-face-font 'default "Iosevka 20")

;;; mac fixes
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(setq frame-resize-pixelwise t)
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;;; builtin modes
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)
(fido-mode t)
(setq compile-command "")
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(delete-selection-mode t)
(setq whitespace-style
      (quote
       (face tabs spaces trailing space-before-tab newline indentation empty space-after-tab space-mark tab-mark)))
(add-hook 'prog-mode-hook (lambda ()
                            (interactive)
                            (whitespace-mode t)
                            (add-to-list 'write-file-functions 'delete-trailing-whitespace)))
(global-hl-line-mode t)
(fringe-mode '(0 . 0))

;;; keybinds
(setq mac-command-modifier 'meta
      mac-option-modifier nil
      mac-right-command-modifier 'super)

(global-set-key (kbd "<escape>") 'ignore)

(global-set-key (kbd "C-,")
                (lambda ()
                  (interactive)
                  (duplicate-line)
                  (next-line)))

;;; packages
;; stolen from @TsodingDaily on yt. it autoinstalls pkgs
(add-to-list 'load-path (expand-file-name "modules/" user-emacs-directory))
(require 'rc)

(rc/require 'doom-themes)
(load-theme 'doom-monokai-pro t)

(rc/require 'magit)
(rc/require 'nix-mode
            'rust-mode)

;;; multiple cursors
(rc/require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

;;; simple c mode - https://github.com/rexim/simpc-mode/
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

;;; company
(rc/require 'company)
(global-company-mode t)

;;; move text
(rc/require 'move-text)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

;;; modeline
(rc/require 'moody)
(moody-replace-mode-line-front-space)
(moody-replace-mode-line-buffer-identification)
(moody-replace-vc-mode)

(rc/require 'minions)
(setq minions-mode-line-lighter ""
      minions-mode-line-delimiters '("" . ""))
(minions-mode t)

;;; org-mode
(rc/require 'org-bullets)
(setq org-use-speed-commands t
      org-startup-indented t)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode t)))

(when (file-exists-p custom-file)
  (load custom-file))
