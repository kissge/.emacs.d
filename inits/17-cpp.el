(with-eval-after-load-feature 'cc-mode
  (defun insert-lt-or-shift-op (arg)
    (interactive "*P")
    (c-electric-lt-gt arg)
    (let ((position-cout (save-excursion
                           (or (search-backward "cout" (point-at-bol) t)
                               (search-backward "cerr" (point-at-bol) t)
                               (search-backward "clog" (point-at-bol) t)))))
      (if position-cout
          (let ((position-paren (save-excursion (search-backward "(" (point-at-bol) t))))
            (if (or (not position-paren) (< position-paren position-cout))
                (insert "< "))))))

  (defun insert-gt-or-shift-op (arg)
    (interactive "*P")
    (c-electric-lt-gt arg)
    (let ((position-cin (save-excursion (search-backward "cin" (point-at-bol) t))))
      (if position-cin
          (let ((position-paren (save-excursion (search-backward "(" (point-at-bol) t))))
            (if (or (not position-paren) (< position-paren position-cin))
                (insert "> "))))))

  (define-key c++-mode-map "<" 'insert-lt-or-shift-op)
  (define-key c++-mode-map ">" 'insert-gt-or-shift-op))

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
(el-get-bundle irony-eldoc)

(el-get-bundle syohex/emacs-cpp-auto-include
  (defun auto-cpp-auto-include ()
    (unless (save-excursion
              (save-match-data
                (goto-char (point-min))
                (search-forward "bits/stdc++.h" nil t)))
      (if (member (this-command-keys) '(";" "<" ">" " " "\^M"))
          (cpp-auto-include))))
  (add-hook 'c++-mode-hook
            (defun c++-mode-my-hook ()
              (add-hook 'post-self-insert-hook 'auto-cpp-auto-include nil t))))
