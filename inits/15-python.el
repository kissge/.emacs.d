(el-get-bundle jedi
  (add-hook 'python-mode-hook 'jedi:setup)
  (custom-set-variables '(jedi:complete-on-dot t)
                        '(jedi:tooltip-method nil))
  (set-face-attribute 'jedi:highlight-function-argument nil :foreground "green"))
