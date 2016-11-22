(el-get-bundle pdf-tools
  (autoload 'pdf-view-mode "pdf-view")
  (setq auto-mode-alist (cons '("\\.pdf$" . pdf-view-mode) auto-mode-alist))
  (add-hook 'pdf-view-mode-hook
            (defun pdf-view-mode-my-hook ()
              (auto-revert-mode)
              (local-set-key (kbd "j") 'pdf-view-next-page-command)
              (local-set-key (kbd "k") 'pdf-view-previous-page-command))))
