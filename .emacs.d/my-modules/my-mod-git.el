(my-emacs-configure
 (setq vc-follow-symlinks t)

 (with-eval-after-load 'vc
    ;; I only use Git.  If I ever need another, I will include it here.
    ;; This may have an effect on performance, as Emacs will not try to
    ;; check for a bunch of backends.
    (setq vc-handled-backends '(Git))

    (setq vc-dir-save-some-buffers-on-revert t)))

(my-emacs-configure
 (use-package magit))

(provide 'my-mod-git)
