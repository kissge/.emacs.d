(el-get-bundle irony-mode
  (with-eval-after-load-feature 'irony
    (defun irony-mode-if-possible ()
      (if (member major-mode irony-supported-major-modes)
          (irony-mode))))
  (add-hook 'c++-mode-hook 'irony-mode-if-possible)
  (add-hook 'c-mode-hook 'irony-mode-if-possible)
  (custom-set-variables
   `(irony-server-install-prefix ,(locate-user-emacs-file ".irony"))))
(el-get-bundle company-irony
  (with-eval-after-load-feature 'company
    (add-to-list 'company-backends 'company-irony)))
