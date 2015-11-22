(el-get-bundle! fringe-helper
  (defvar flymake-fringe-overlays nil)
  (make-variable-buffer-local 'flymake-fringe-overlays)
  (custom-set-variables '(flymake-run-in-place nil))
  (defadvice flymake-make-overlay (after add-to-fringe first
                                         (beg end tooltip-text face mouse-face)
                                         activate compile)
    (push (fringe-helper-insert-region
           beg end
           (fringe-lib-load (if (eq face 'flymake-errline)
                                fringe-lib-exclamation-mark
                              fringe-lib-question-mark))
           'left-fringe 'font-lock-warning-face)
          flymake-fringe-overlays))
  (defadvice flymake-delete-own-overlays (after remove-from-fringe activate compile)
    (mapc 'fringe-helper-remove flymake-fringe-overlays)
    (setq flymake-fringe-overlays nil)))
(el-get-bundle with-editor
  :type http
  :url "https://raw.githubusercontent.com/magit/magit/master/lisp/with-editor.el")
(el-get-bundle git-commit
  :type http
  :url "https://raw.githubusercontent.com/magit/magit/master/lisp/git-commit.el")
(el-get-bundle! git-gutter+ in nonsequitur/git-gutter-plus
  (global-git-gutter+-mode)
  (define-key git-gutter+-mode-map (kbd "C-x n") 'git-gutter+-next-hunk)
  (define-key git-gutter+-mode-map (kbd "C-x p") 'git-gutter+-previous-hunk)
  (define-key git-gutter+-mode-map (kbd "C-x ?") 'git-gutter+-show-hunk)
  (define-key git-gutter+-mode-map (kbd "C-x r") 'git-gutter+-revert-hunks)
  (define-key git-gutter+-mode-map (kbd "C-x t") 'git-gutter+-stage-hunks)
  (define-key git-gutter+-mode-map (kbd "C-x c") 'git-gutter+-commit)
  (define-key git-gutter+-mode-map (kbd "C-x C") 'git-gutter+-stage-and-commit))
(if window-system
    (el-get-bundle! git-gutter-fringe+ in nonsequitur/git-gutter-fringe-plus))
