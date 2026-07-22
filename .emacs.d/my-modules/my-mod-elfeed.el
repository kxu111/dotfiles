(my-emacs-configure
  (use-package elfeed
    :bind ("C-x f" . elfeed)
    :hook (elfeed-show-mode . visual-line-mode))

  (use-package elfeed-org
    :config (elfeed-org))

  (use-package elfeed-tube
    :config (elfeed-tube-setup)
    :bind
    (:map elfeed-show-mode-map
          ("F" . elfeed-tube-fetch)
          ([remap save-buffer] . elfeed-tube-save))
    (:map elfeed-search-mode-map
          ("F" . elfeed-tube-fetch)
          ([remap save-buffer] . elfeed-tube-save)))

  (use-package mpv)
  (use-package elfeed-tube-mpv
    :bind
    (:map elfeed-show-mode-map
          ("<return>" . elfeed-tube-mpv)
          ("C-c C-f" . elfeed-tube-mpv-follow-mode)
          ("C-c C-w" . elfeed-tube-mpv-where))))

(provide 'my-mod-elfeed)
