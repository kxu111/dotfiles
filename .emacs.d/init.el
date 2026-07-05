(setq inhibit-startup-message t)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(tooltip-mode 0)
(menu-bar-mode 0)
(setq ring-bell-function 'ignore)
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)
(set-face-attribute 'default nil :font "Iosevka Term" :height 200)
(setq vc-follow-symlinks t)

;;; mac fixes
(add-to-list 'default-frame-alist '(undecorated . t))
(add-to-list 'default-frame-alist '(internal-border-width . 0))
(add-to-list 'default-frame-alist '(left-fringe . 0))
(add-to-list 'default-frame-alist '(right-fringe . 0))
(setq frame-resize-pixelwise t)
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;;; builtin modes
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)
;; disable linenrs for certain modes
(dolist (mode '(term-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(fido-mode)

(setq compile-command "")

;; auto-kill term buffer on exits
(add-hook 'term-exec-hook
          (lambda ()
            (set-process-sentinel (get-buffer-process (current-buffer))
                                  (lambda (proc event)
                                    (when (string-match "finished" event)
                                      (kill-buffer (process-buffer proc)))))))

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
(load (expand-file-name "modules/rc.el" user-emacs-directory))

(rc/require-theme 'gruber-darker)
(rc/require 'magit)
(rc/require 'nix-mode)

;;; multiple cursors
(rc/require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

;;; simple c mode - https://github.com/rexim/simpc-mode/
(add-to-list 'load-path (expand-file-name "modules/" user-emacs-directory))
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

;;; company
(rc/require 'company)
(global-company-mode)

;; ;;; yasnippet
;; (rc/require 'yasnippet)
;; (setq yas-snippet-dirs (expand-file-name "snippets/" user-emacs-directory))
;; (yas-global-mode)
