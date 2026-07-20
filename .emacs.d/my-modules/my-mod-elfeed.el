(my-emacs-configure
 (use-package elfeed
   :bind ("C-x f" . elfeed)
   :hook (elfeed-show-mode . visual-line-mode)
   :custom (elfeed-search-filter "@6months +unread -junk"))

 (use-package elfeed-org
   :after elfeed
   :config (elfeed-org)))

(my-emacs-configure
 (use-package elfeed-tube
   :after elfeed
   :bind
   (:map elfeed-show-mode-map
         ("F" . elfeed-tube-fetch)
         ([remap save-buffer] . elfeed-tube-save))
   (:map elfeed-search-mode-map
         ("F" . elfeed-tube-fetch)
         ([remap save-buffer] . elfeed-tube-save))
   :config
   (elfeed-tube-setup)
   (add-hook 'elfeed-new-entry-hook
             (elfeed-make-tagger :entry-link "https://www\\.youtube\\.com/shorts/.*"
                                 :add 'junk
                                 :remove 'unread)))

 (use-package mpv)
 (use-package elfeed-tube-mpv
   :after elfeed
   :bind
   (:map elfeed-show-mode-map
         ("<return>" . elfeed-tube-mpv)
         ("C-c C-f" . elfeed-tube-mpv-follow-mode)
         ("C-c C-w" . elfeed-tube-mpv-where))))

(provide 'my-mod-elfeed)
