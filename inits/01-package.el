(el-get-bundle tarao/with-eval-after-load-feature-el)

(el-get-bundle! flymake
  (add-hook 'flymake-mode-hook
            (lambda ()
              (local-set-key (kbd "M-p") 'flymake-goto-prev-error)
              (local-set-key (kbd "M-n") 'flymake-goto-next-error))))
(el-get-bundle! company in company-mode
  (add-hook 'after-init-hook 'global-company-mode)
  (custom-set-variables '(company-idle-delay 0)
                        '(company-minimum-prefix-length 4)
                        '(company-selection-wrap-around t))
  ;; http://qiita.com/sune2/items/b73037f9e85962f5afb7
  (defun company--insert-candidate2 (candidate)
    (when (> (length candidate) 0)
        (setq candidate (substring-no-properties candidate))
        (if (eq (company-call-backend 'ignore-case) 'keep-prefix)
            (insert (company-strip-prefix candidate))
          (if (equal company-prefix candidate)
              (company-select-next)
            (delete-region (- (point) (length company-prefix)) (point))
            (insert candidate)))))
  (defun company-complete-common2 ()
    (interactive)
    (when (company-manual-begin)
      (if (and (not (cdr company-candidates))
               (equal company-common (car company-candidates)))
          (company-complete-selection)
        (company--insert-candidate2 company-common))))
  (define-key company-active-map [tab] 'company-complete-common2)
  (define-key company-active-map [backtab] 'company-select-previous)
  (push (apply-partially
         #'cl-remove-if
         (lambda (c)
           (or (string-match-p "[^\x00-\x7F]+" c)
               (string-match-p "^[0-9]\\{,4\\}$" c))))
        company-transformers))
(el-get-bundle pos-tip)
(el-get-bundle company-quickhelp
  (when window-system (company-quickhelp-mode)))
(el-get-bundle! session
  (custom-set-variables '(history-length 10000)
                        '(history-delete-duplicates t)
                        '(session-globals-max-size 999999999999)
                        '(session-globals-include nil))
  (with-eval-after-load-feature 'session
    (setq session-set-file-name-exclude-regexp
          (concat session-set-file-name-exclude-regexp "\\|" "[/\\]\\.scratch" "\\|" "[/\\]geben[/\\]" "\\|" "\\.loaddefs\\.el")))
    (defadvice write-region (before force-quiet)
      (ad-set-arg 4 0))
    (add-hook 'after-init-hook
              (lambda ()
                (session-initialize)
                (add-hook 'find-file-hook
                          (lambda ()
                            (ad-activate 'write-region)
                            (session-save-session)
                            (ad-deactivate 'write-region))))))
(el-get-bundle dash)
(el-get-bundle undo-tree
  (global-undo-tree-mode 1)
  (global-set-key (kbd "C-z") 'undo-tree-undo)
  (global-set-key (kbd "C-S-z") 'undo-tree-redo)
  (global-set-key (kbd "C-_") 'undo-tree-undo)
  (custom-set-variables `(undo-tree-history-directory-alist `(("." . ,(locate-user-emacs-file ".undo"))))
                        '(undo-tree-auto-save-history t)))
(el-get-bundle ws-butler
  (ws-butler-global-mode))
(el-get-bundle zlc
  (zlc-mode t)
  (define-key minibuffer-local-map (kbd "/") nil))
(el-get-bundle multiple-cursors
  (global-set-key (kbd "C-: C-]") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-: C-[") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-: C-}") 'mc/unmark-next-like-this)
  (global-set-key (kbd "C-: C-{") 'mc/unmark-previous-like-this)
  (global-set-key (kbd "C-: C-:") 'mc/mark-all-dwim))
(el-get-bundle visual-regexp)
(el-get-bundle visual-regexp-steroids
  (with-eval-after-load-feature 'visual-regexp
    (require 'visual-regexp-steroids))
  (global-set-key (kbd "M-%") 'vr/query-replace)
  (global-set-key (kbd "C-c m") 'vr/mc-mark)
  (global-set-key (kbd "C-M-r") 'vr/isearch-backward)
  (global-set-key (kbd "C-M-s") 'vr/isearch-forward))
(el-get-bundle markdown-mode
  (add-hook 'markdown-mode-hook
            (defun markdown-mode-my-hook ()
              (dolist (key
                       (list
                        (kbd "<M-left>") (kbd "<M-right>")
                        (kbd "<M-S-left>") (kbd "<M-S-right>")))
                (local-unset-key key)))))
(el-get-bundle powershell)
(el-get-bundle! yasnippet
  (yas-global-mode 1)
  (define-key yas-minor-mode-map [backtab] 'yas-expand)
  (define-key yas-minor-mode-map [(tab)] nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (autoload 'string-inflection-camelcase-function "string-inflection"))
(let ((bluebird (expand-file-name "~/Dropbox/Settings/bluebird.el")))
  (if (and (not env-hikarie) (file-exists-p bluebird))
      (el-get-bundle hayamiz/twittering-mode
        (custom-set-variables
         '(twittering-status-format "%i @%s / %S %p: \n %T\n [%@]%r %R %f%L\n")
         '(twittering-retweet-format " RT @%s: %t")
         '(twittering-use-ssl 1)
         '(twittering-icon-mode nil)
         '(twittering-convert-fix-size 48)
         '(twittering-timer-interval 120)
         '(twittering-update-status-function 'twittering-update-status-from-minibuffer))
        (define-key twittering-mode-map (kbd "f") 'twittering-favorite)
        (define-key twittering-mode-map (kbd "r") 'twittering-reply-to-user)
        (define-key twittering-mode-map (kbd "t") 'twittering-native-retweet)
        (define-key twittering-mode-map (kbd "m") 'twittering-direct-message)
        (define-key twittering-mode-map (kbd "N") 'twittering-update-status-interactive)
        (define-key twittering-mode-map (kbd "C-c C-f") 'twittering-home-timeline)
        (add-hook 'twittering-mode-hook (lambda () (setq truncate-partial-width-windows nil)))
        (load-file bluebird))))
