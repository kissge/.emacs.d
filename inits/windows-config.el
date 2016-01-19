(tool-bar-mode 0)
(menu-bar-mode 0)

;; workaround for Windows-style path separator specific problem
;; hint: locate-user-emacs-file, replace-match
(advice-add 'locate-user-emacs-file :filter-return 'expand-file-name)
