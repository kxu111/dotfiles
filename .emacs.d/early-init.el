(defun prot-emacs-re-enable-frame-theme (_frame)
  (when-let* ((theme (car custom-enabled-themes)))
    (enable-theme theme)))

(defun prot-emacs-avoid-initial-flash-of-light ()
  (setq mode-line-format nil)
  (set-face-attribute 'default nil :background "#000000" :foreground "#ffffff")
  (set-face-attribute 'mode-line nil :background "#000000" :foreground "#ffffff" :box 'unspecified)
  (add-hook 'after-make-frame-functions #'prot-emacs-re-enable-frame-theme))

(prot-emacs-avoid-initial-flash-of-light)

(setq gc-cons-threshold 100000000)

(setq package-enable-at-startup nil)
