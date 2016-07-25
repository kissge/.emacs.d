(el-get-bundle company-jedi
  (with-eval-after-load-feature 'company
    (add-to-list 'company-backends 'company-jedi))
  (custom-set-variables '(jedi:complete-on-dot t)
                        '(jedi:tooltip-method nil))
  (with-eval-after-load-feature 'jedi-core
    (set-face-attribute 'jedi:highlight-function-argument nil :foreground "green"))
  (if (executable-find "python3")
      (custom-set-variables '(jedi:environment-root "jedi")
                            '(jedi:environment-virtualenv
                              (append python-environment-virtualenv
                                      `("--python" ,(executable-find "python3")))))))
