(my-emacs-configure
 (use-package org
   :straight (:host github :repo "bzg/org-mode" :branch "main")
   :hook (org-mode . visual-line-mode)
   :custom
   (org-use-speed-commands t) ; M-x org-speed-commands-help
   (org-startup-indented t)
   (org-hide-emphasis-markers t)
   (org-cycle-separator-lines 1) ; Keep a line between folded headings
   (org-src-content-indentation 0)
   ))

(my-emacs-configure
  (org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (shell . t)
    ))

 (require 'org-tempo)
 (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
 (add-to-list 'org-structure-template-alist '("sh" . "src shell")))

(my-emacs-configure
 (use-package org-roam
   :bind
   ("C-c n c" . org-roam-capture)
   ("C-c n f" . org-roam-node-find)
   ("C-c n i" . org-roam-node-insert)
   :custom (org-capture-bookmark nil)
   :config (org-roam-db-autosync-mode t))

 ;; ":commands" implies defer until the command is run
 (use-package org-roam-ui :commands org-roam-ui-mode))

(provide 'my-mod-org)
