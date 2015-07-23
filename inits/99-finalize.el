(el-get-bundle! session
  (setq history-length 10000)
  (setq history-delete-duplicates t)
  (custom-set-variables
   `(session-set-file-name-exclude-regexp
     ,(concat session-set-file-name-exclude-regexp "\\|" "[/\\]\\.scratch" "\\|" "[/\\]geben[/\\]" "\\|" "\\.loaddefs\\.el")))
  (session-initialize)
  (defadvice write-region (before force-quiet)
    (ad-set-arg 4 0))
  (add-hook 'find-file-hook
            (lambda ()
              (ad-activate 'write-region)
              (session-save-session)
              (ad-deactivate 'write-region))))
