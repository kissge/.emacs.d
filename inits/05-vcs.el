(el-get-bundle! fringe-helper)
(el-get-bundle git-commit-mode in magit/git-modes)
(el-get-bundle! elpa:git-gutter+
  (with-eval-after-load-feature 'git-gutter+
    (global-git-gutter+-mode)
    (define-key git-gutter+-mode-map (kbd "C-x n") 'git-gutter+-next-hunk)
    (define-key git-gutter+-mode-map (kbd "C-x p") 'git-gutter+-previous-hunk)
    (define-key git-gutter+-mode-map (kbd "C-x ?") 'git-gutter+-show-hunk)
    (define-key git-gutter+-mode-map (kbd "C-x r") 'git-gutter+-revert-hunks)
    (define-key git-gutter+-mode-map (kbd "C-x t") 'git-gutter+-stage-hunks)
    (define-key git-gutter+-mode-map (kbd "C-x c") 'git-gutter+-commit)
    (define-key git-gutter+-mode-map (kbd "C-x C") 'git-gutter+-stage-and-commit)))
(el-get-bundle elpa:git-gutter-fringe+
  (with-eval-after-load-feature 'git-gutter+
    (require 'git-gutter-fringe+)))
