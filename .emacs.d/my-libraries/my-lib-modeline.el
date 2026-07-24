(defvar my-modeline-icons
  '((dired-mode   "")
    (archive-mode "🮯")
    (diff-mode    "⇄")
    (prog-mode    "λ")
    (conf-mode    "¶")
    (text-mode    "¶")
    (comint-mode  "⨠")
    (t            "·")))

(defun my-modeline-get-icon ()
  (or
   (cadr (assq major-mode my-modeline-icons))
   (catch 'icon
     (dolist (entry my-modeline-icons)
       (when (and (not (eq (car entry) t)) (derived-mode-p (car entry)))
         (throw 'icon (cadr entry)))))
   (cadr (assq t my-modeline-icons))))

(defgroup my-modeline nil
  "Custom modeline that is stylistically close to the default."
  :group 'mode-line)

(defgroup my-modeline-faces nil
  "Faces for my custom modeline."
  :group 'my-modeline)

;; These blocks check if Emacs can display a sufficient amount of colors, and then checks if the theme is light or dark
(defface my-faces-red
  '((((class color) (min-colors 88) (background light)) :foreground "#aa3232")
    (((class color) (min-colors 88) (background dark)) :foreground "#f06464")
    (t :foreground "red"))
  "Use for red-colored icons"
  :group 'my-modeline-faces)

(defface my-faces-gray
  '((t :inherit (bold shadow)))
  "Use for gray-colored icons."
  :group 'my-modeline-faces)

(defvar my-modeline-read-only
  '(:eval
    (when buffer-read-only
      (propertize
       " "
       'face (if (mode-line-window-selected-p)
                 'my-faces-red
               'my-faces-gray)))))

(defvar my-modeline-buffer-name
  '(:eval
    (propertize (buffer-name) 'face
                (if (buffer-modified-p)
                    '(:weight bold :slant italic) 'bold))))

(defvar my-modeline-major-mode
  '(:eval
    (format "%s %s"
            (propertize (my-modeline-get-icon) 'face 'my-faces-gray)
            (capitalize (string-replace "-mode" "" (symbol-name major-mode))))))

(defvar my-modeline-vc
  '(:eval
    (when (mode-line-window-selected-p)
      (unless (not vc-mode)
        (let ((s (capitalize (substring-no-properties vc-mode 5))))
          (concat
           (propertize "⇅ " 'face 'my-faces-gray)
           (if (eq (vc-state buffer-file-name) 'up-to-date)
               s
             (propertize s 'face 'italic))))))))

(defvar my-modeline-multiple-cursors
  '(:eval
    (when (and (mode-line-window-selected-p) (bound-and-true-p multiple-cursors-mode))
      mc/mode-line)))

(defvar my-modeline-position
  '(:eval
    (when (mode-line-window-selected-p)
      (format-mode-line "%6l:%c (%%p)"))))

(defvar my-modeline-misc-info
    '(:eval
      (when (mode-line-window-selected-p)
        mode-line-misc-info)))

(provide 'my-lib-modeline)
