;; Disable package in favour of "straight.el".
(setq package-enable-at-startup nil)

(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize 'force
      ring-bell-function 'ignore
      use-short-answers t
      inhibit-startup-screen t
      )

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(blink-cursor-mode -1)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; MacOS options
(when (eq system-type 'darwin)
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist '(undecorated-round . t))
  (setq mac-command-modifier 'meta
	mac-right-command-modifier 'super
	mac-option-modifier nil))

;; Temporarily increase the garbage collection threshold.  These
;; changes help shave off about half a second of startup time.  The
;; `most-positive-fixnum' is DANGEROUS AS A PERMANENT VALUE.  See the
;; `emacs-startup-hook' a few lines below for what I actually use.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.5)

;; Same idea as above for the `file-name-handler-alist' and the
;; `vc-handled-backends' with regard to startup speed optimisation.
;; Here I am storing the default value with the intent of restoring it
;; via the `emacs-startup-hook'.
(defvar my-emacs--file-name-handler-alist file-name-handler-alist)
(defvar my-emacs--vc-handled-backends vc-handled-backends)

(setq file-name-handler-alist nil
      vc-handled-backends nil)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 100 100 8)
                  gc-cons-percentage 0.1
                  file-name-handler-alist my-emacs--file-name-handler-alist
                  vc-handled-backends my-emacs--vc-handled-backends)))

(defun my-emacs-re-enable-theme (_frame)
  (when-let* ((theme (car custom-enabled-themes)))
    (enable-theme theme)))

;; Make the initial frame match your theme's background colors.
(defun my-emacs-fix-start-bg ()
  (setq mode-line-format nil)
  (set-face-attribute 'default nil :background "#000000" :foreground "#ffffff")
  (set-face-attribute 'mode-line nil :background "#000000" :foreground "#ffffff" :box 'unspecified)
  (add-hook 'after-make-frame-functions #'my-emacs-re-enable-theme))

(my-emacs-fix-start-bg)
