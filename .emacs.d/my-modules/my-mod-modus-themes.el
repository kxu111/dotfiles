(my-emacs-configure
  (use-package modus-themes)

  (modus-themes-include-derivatives-mode t)

  (setq modus-themes-mixed-fonts t
        modus-themes-variable-pitch-ui t
        modus-themes-italic-constructs t
        modus-themes-bold-constructs t
        modus-themes-completions '((t . (bold)))
        modus-themes-prompts '(bold)
        modus-themes-headings
        '((agenda-structure . (variable-pitch light 2.2))
          (agenda-date . (variable-pitch regular 1.3))
          (t . (regular 1.15)))
	)

  (setq modus-themes-common-palette-overrides nil)

  (setq modus-vivendi-palette-overrides
        `((fg-main "#d6d6d4")
          (bg-main "#090909")
	  (fg-mode-line-active "#ffffff")
          (bg-mode-line-active bg-lavender)
          (bg-region bg-lavender))))

(provide 'my-mod-modus-themes)
