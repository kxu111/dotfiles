(defvar my-major-mode-icons
  '((dired-mode   "")
    (prog-mode    "λ")
    (conf-mode    "Σ")
    (text-mode    "§")
    (t            "·")))

(defun my-major-mode-get-icon ()
  (or
   (cadr (assq major-mode my-major-mode-icons))
   (catch 'icon
     (dolist (entry my-major-mode-icons)
       (when (and (not (eq (car entry) t)) (derived-mode-p (car entry)))
         (throw 'icon (cadr entry)))))
   (cadr (assq t my-major-mode-icons))))

(defgroup my-modeline-faces nil
  "Faces for my custom modeline."
  :group 'mode-line)

(defface my-modeline-bg nil
  "Modify this to define what a bg should look like. For example, add a `:box' attribute.")

(defface my-modeline-red
  '((((class color) (min-colors 88) (background light)) :foreground "#880000")
    (((class color) (min-colors 88) (background dark)) :foreground "#ff9f9f")
    (t :foreground "red"))
  "Face for modeline."
  :group 'my-modeline-faces)

(defface my-modeline-red-bg
  '((default :inherit my-modeline-bg)
    (((class color) (min-colors 88) (background light)) :background "#aa1111" :foreground "white")
    (((class color) (min-colors 88) (background dark)) :background "#ff9090" :foreground "black")
    (t :background "red" :foreground "black"))
  "Face for modeline with a background."
  :group 'my-modeline-faces)

(defface my-modeline-green
  '((((class color) (min-colors 88) (background light)) :foreground "#005f00")
    (((class color) (min-colors 88) (background dark)) :foreground "#73fa7f")
    (t :foreground "green"))
  "Face for modeline."
  :group 'my-modeline-faces)

(defface my-modeline-green-bg
  '((default :inherit my-modeline-bg)
    (((class color) (min-colors 88) (background light)) :background "#207b20" :foreground "white")
    (((class color) (min-colors 88) (background dark)) :background "#77d077" :foreground "black")
    (t :background "green" :foreground "black"))
  "Face for modeline with a background."
  :group 'my-modeline-faces)

(defface my-modeline-yellow
  '((((class color) (min-colors 88) (background light)) :foreground "#6f4000")
    (((class color) (min-colors 88) (background dark)) :foreground "#f0c526")
    (t :foreground "yellow"))
  "Face for modeline."
  :group 'my-modeline-faces)

(defface my-modeline-yellow-bg
  '((default :inherit my-modeline-bg)
    (((class color) (min-colors 88) (background light)) :background "#805000" :foreground "white")
    (((class color) (min-colors 88) (background dark)) :background "#ffc800" :foreground "black")
    (t :background "yellow" :foreground "black"))
  "Face for modeline with a background."
  :group 'my-modeline-faces)

(defface my-modeline-blue
  '((((class color) (min-colors 88) (background light)) :foreground "#00228a")
    (((class color) (min-colors 88) (background dark)) :foreground "#88bfff")
    (t :foreground "blue"))
  "Face for modeline."
  :group 'my-modeline-faces)

(defface my-modeline-blue-bg
  '((default :inherit my-modeline-bg)
    (((class color) (min-colors 88) (background light)) :background "#0000aa" :foreground "white")
    (((class color) (min-colors 88) (background dark)) :background "#77aaff" :foreground "black")
    (t :background "blue" :foreground "black"))
  "Face for modeline with a background."
  :group 'my-modeline-faces)

(defface my-modeline-magenta
  '((((class color) (min-colors 88) (background light)) :foreground "#6a1aaf")
    (((class color) (min-colors 88) (background dark)) :foreground "#e0a0ff")
    (t :foreground "magenta"))
  "Face for modeline."
  :group 'my-modeline-faces)

(defface my-modeline-magenta-bg
  '((default :inherit my-modeline-bg)
    (((class color) (min-colors 88) (background light)) :background "#6f0f9f" :foreground "white")
    (((class color) (min-colors 88) (background dark)) :background "#e3a2ff" :foreground "black")
    (t :background "magenta" :foreground "black"))
  "Face for modeline with a background."
  :group 'my-modeline-faces)

(defface my-modeline-cyan
  '((((class color) (min-colors 88) (background light)) :foreground "#004060")
    (((class color) (min-colors 88) (background dark)) :foreground "#30b7cc")
    (t :foreground "cyan"))
  "Face for modeline."
  :group 'my-modeline-faces)

(defface my-modeline-cyan-bg
  '((default :inherit my-modeline-bg)
    (((class color) (min-colors 88) (background light)) :background "#006080" :foreground "white")
    (((class color) (min-colors 88) (background dark)) :background "#40c0e0" :foreground "black")
    (t :background "cyan" :foreground "black"))
  "Face for modeline with a background."
  :group 'my-modeline-faces)

(defface my-modeline-gray
  '((t :inherit (shadow)))
  "Face for modeline."
  :group 'my-modeline-faces)

(defface my-modeline-gray-bg
  '((default :inherit my-modeline-bg)
    (((class color) (min-colors 88) (background light)) :background "#808080" :foreground "white")
    (((class color) (min-colors 88) (background dark)) :background "#a0a0a0" :foreground "black")
    (t :inverse-video t))
  "Face for modeline indicator with a background."
  :group 'my-modeline-faces)

(defvar my-modeline-read-only
  '(:eval
    (when buffer-read-only
      (propertize
       " "
       'face (if (mode-line-window-selected-p)
		 'my-modeline-red
	       'my-modeline-gray)))))

(defvar my-modeline-buffer-name
  '(:eval
    (propertize (buffer-name) 'face
                (if (buffer-modified-p)
                    '(:weight bold :slant italic) 'bold))))

(defvar my-modeline-major-mode
  '(:eval
    (format "%s %s"
            (propertize (my-major-mode-get-icon) 'face 'my-modeline-gray)
            (capitalize (string-replace "-mode" "" (symbol-name major-mode))))))

(defvar my-modeline-vc
  '(:eval
    (when (mode-line-window-selected-p)
      (unless (not vc-mode)
        (let ((s (capitalize (substring-no-properties vc-mode 5))))
          (concat
           (propertize "⇅ " 'face 'my-modeline-gray)
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
      (let ((misc (format-mode-line mode-line-misc-info)))
        (unless (string-empty-p misc)
          (concat " " misc))))))

(provide 'my-lib-modeline)
