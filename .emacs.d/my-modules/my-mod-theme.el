(require 'my-mod-modus-themes)
(require 'my-mod-ef-themes)
(require 'my-mod-doric-themes)
(require 'my-mod-standard-themes)
(load-theme 'ef-owl)

(my-emacs-configure
  (use-package fontaine)

  (fontaine-mode t)

  (define-key global-map (kbd "C-c f") #'fontaine-set-preset)
  (define-key global-map (kbd "C-c F") #'fontaine-toggle-preset)

  (setq-default text-scale-remap-header-line t)

  (setq fontaine-presets
	'((Aporetic-Sans-Regular
	   :default-height 200
	   :default-family "Aporetic Sans Mono"
	   :fixed-pitch-family "Aporetic Sans Mono"
	   :variable-pitch-family "Aporetic Sans")
	  (Aporetic-Sans-Large
	   :default-height 260
	   :default-family "Aporetic Sans Mono"
	   :fixed-pitch-family "Aporetic Sans Mono"
	   :variable-pitch-family "Aporetic Sans")

          (Aporetic-Serif-Regular
	   :default-height 200
	   :default-family "Aporetic Serif Mono"
	   :fixed-pitch-family "Aporetic Serif Mono"
	   :variable-pitch-family "Aporetic Serif")
	  (Aporetic-Serif-Large
	   :default-height 260
	   :default-family "Aporetic Serif Mono"
	   :fixed-pitch-family "Aporetic Serif Mono"
	   :variable-pitch-family "Aporetic Serif")

	  (t
	   :default-height 200
	   :default-family "Aporetic Serif Mono"
	   :fixed-pitch-family "Aporetic Serif Mono"
	   :variable-pitch-family "Aporetic Serif")
	  ))

  (fontaine-set-preset (or (fontaine-restore-latest-preset) 'regular))

  (with-eval-after-load 'pulsar
    (add-hook 'fontaine-set-preset-hook #'pulsar-pulse-line)))

(when (display-graphic-p)
  (my-emacs-configure
    (use-package spacious-padding)

    (define-key global-map (kbd "<f8>") #'spacious-padding-mode)

    (setq spacious-padding-widths
          `( :internal-border-width 15
             :header-line-width 4
             :mode-line-width 6
             :tab-width 4
             :right-divider-width 15
             :left-fringe-width 8
             :right-fringe-width 20))

    (setq spacious-padding-subtle-frame-lines
          '( :mode-line-active spacious-padding-line-active
             :mode-line-inactive spacious-padding-line-inactive
             ;; :header-line-active spacious-padding-line-active
             ;; :header-line-inactive spacious-padding-line-inactive
	     ))

    (when (< emacs-major-version 29)
      (setq x-underline-at-descent-line (when spacious-padding-subtle-frame-lines t))))

  (spacious-padding-mode t))

(provide 'my-mod-theme)
