(when env-hikarie
  (setq-default tags-file-name "/eng4:TAGS")
)

(when env-ms
  (global-set-key
   (kbd "C-x ,")
   (defun git-add-force-this-file ()
     (interactive)
     (shell-command (concat "git add -f \"" (buffer-file-name) "\""))))
  )
