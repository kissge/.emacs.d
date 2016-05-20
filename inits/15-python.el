(el-get-bundle jedi
  (add-hook 'python-mode-hook 'jedi:setup)
  (custom-set-variables '(jedi:complete-on-dot t)))
