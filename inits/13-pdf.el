(when (executable-find "make")
  (el-get-bundle pdf-tools
    (add-hook 'doc-view-mode-hook
              (defun pdf-view-mode-initialize ()
                (pdf-tools-install)
                (remove-hook 'doc-view-mode-hook 'pdf-view-mode-initialize)))
    (add-hook 'pdf-view-mode-hook
              (defun pdf-view-mode-my-hook ()
                (auto-revert-mode)
                (local-set-key (kbd "j") 'pdf-view-next-page-command)
                (local-set-key (kbd "k") 'pdf-view-previous-page-command)))))
