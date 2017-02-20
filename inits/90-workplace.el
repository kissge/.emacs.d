(when env-hikarie
  (setq-default tags-file-name "/eng4:TAGS")
)

(when env-ms
  (prefer-coding-system 'utf-8-dos)
  (custom-set-variables '(nxml-child-indent 4))
  (setq auto-mode-alist
      (append '(("\\.uix$" . xml-mode)
                ("\\.dm$" . xml-mode)
                ("\\.ds$" . xml-mode)
                )
              auto-mode-alist))
  (global-set-key
   (kbd "C-x ,")
   (defun git-add-force-this-file ()
     (interactive)
     (shell-command (concat "git add -f \"" (buffer-file-name) "\""))))
  )
