(when env-hikarie
  (add-hook 'html-mode-hook
            (lambda ()
              (setq tab-width 4)
              (set (make-local-variable 'sgml-basic-offset) 4)))
  (add-hook 'js2-mode-hook
            (lambda ()
              (setq tab-width 4)
              (set (make-local-variable 'sgml-basic-offset) 4)))
  (setq-default tags-file-name "/eng4:TAGS")
)
