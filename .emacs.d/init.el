;; Bootstrap "straight.el"
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
  (setq straight-profiles `((base . "~/dotfiles/.emacs.d/lockfile.el"))))

;; Make native compilation silent.
(when (native-comp-available-p)
  (setq native-comp-async-report-warnings-errors 'silent))

;; Disable the custom file by sending it to the temporary directory.
(setq custom-file (make-temp-file "emacs-custom-"))

(setq custom-safe-themes t)

(defmacro my-emacs-configure (&rest body)
  "Evaluate BODY and catch any errors."
  (declare (indent 0))
  `(condition-case err
       (progn ,@body)
     ((error user-error quit)
      (warn "Failed to configure package starting with `%S' because of `%S'" (car ',body) (cdr err)))))

(defmacro my-emacs-hook (hooks functions &optional remove after)
  "For each HOOKS `add-hook' the FUNCTIONS.
With optional REMOVE as non-nil, then `remove-hook' the FUNCTIONS from
HOOKS.

With optional AFTER as the unquoted symbol of a feature, do so after the
given feature is available."
  (declare (indent 0))
  (cond
   ((symbolp hooks)
    (setq hooks (list hooks)))
   ((not (proper-list-p hooks))
    (error "The hooks are not a list: `%S'" hooks)))
  (cond
   ((symbolp functions)
    (setq functions (list functions)))
   ((not (proper-list-p functions))
    (error "The functions are not a list: `%S'" functions)))
  (let* ((fn (if remove 'remove-hook 'add-hook))
         (body (mapcar
                (lambda (h)
                  (mapcar
                   (lambda (f) `(,fn ',h #',f))
                   functions))
                hooks))
         (hooks nil))
    (dolist (element body)
      (dolist (hook element)
        (push hook hooks)))
    (setq hooks (nreverse hooks))
    (cond
     (after
      `(with-eval-after-load ',after ,@hooks))
     ((length> hooks 1)
      `(progn ,@hooks))
     (t
      (car hooks)))))

(defvar my-bind-overrides-mode-map (make-sparse-keymap)
  "Keymap for `my-bind-overrides-mode'.")

(define-minor-mode my-bind-overrides-mode
  "Activate `my-bind-overrides-mode-map'."
  :global t
  :init-value nil
  :keymap my-bind-overrides-mode-map)

(add-hook 'emacs-startup-hook #'my-bind-overrides-mode)

(mapc
 (lambda (string)
   (add-to-list 'load-path (locate-user-emacs-file string)))
 '("my-libraries" "my-modules"))

(require 'my-mod-theme)
(require 'my-mod-essentials)
(require 'my-mod-modeline)
(require 'my-mod-git)
(require 'my-mod-org)
(require 'my-mod-prog)
(require 'my-mod-text-editing)
(require 'my-mod-completions)
(require 'my-mod-elfeed)
