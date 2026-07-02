;; annoyances
(setq inhibit-startup-message t)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(tooltip-mode 0)
(menu-bar-mode 0)
(setq ring-bell-function 'ignore)
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file t))

;; mac fixes
(setq mac-command-modifier 'meta
      mac-option-modifier nil
      mac-right-command-modifier 'super)
(add-to-list 'default-frame-alist '(undecorated . t))
(add-to-list 'default-frame-alist '(internal-border-width . 0))
(add-to-list 'default-frame-alist '(left-fringe . 0))
(add-to-list 'default-frame-alist '(right-fringe . 0))
(setq frame-resize-pixelwise t)
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; builtin modes
(column-number-mode 1)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(ido-mode 1)
(ido-everywhere 1)

(set-face-attribute 'default nil :font "Iosevka Term" :height 200)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(defun duplicate-line-and-next ()
  (interactive)
  (duplicate-line 1)
  (next-line 1))
(global-set-key (kbd "C-,") 'duplicate-line-and-next)

;; initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
   (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package gruber-darker-theme)
(load-theme 'gruber-darker)

;; (use-package zenburn-theme)
;; (load-theme 'zenburn)

;; ido mode for M-x
(use-package smex
:bind (("M-x" . smex)
       ("M-X" . smex-major-mode-commands)
       ("C-c C-c M-x" . execute-extended-command)))
