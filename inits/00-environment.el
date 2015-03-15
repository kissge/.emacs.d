(defconst env-hikarie (string-match-p "^vmac" system-name))

(setq make-backup-files t)
(setq backup-directory-alist
      `(("." . ,(locate-user-emacs-file ".backup")) . ,backup-directory-alist))
(setq auto-save-file-name-transforms
      `((".*" ,(locate-user-emacs-file ".backup") t)))
(setq create-lockfiles nil)

(custom-set-variables `(tramp-persistency-file-name ,(locate-user-emacs-file ".tramp"))
                      '(tramp-auto-save-directory "/tmp")
                      '(tramp-default-proxies-alist '(((regexp-quote (system-name)) nil nil)
                                                      ("localhost" nil nil)
                                                      (nil "\\`root\\'" "/ssh:%h:"))))

(setq completion-ignored-extensions
      (append completion-ignored-extensions
              '(".exe" ".com" ".o" ".out" "./" "../" ".docx" ".xlsx" "#" ".DS_Store" ".zip" ".tar.gz" ".tgz" "Icon\n" "TAGS")))
(defadvice completion-file-name-table (after ignoring-backups-f-n-completion activate)
  "filter out results when the have completion-ignored-extensions"
  (let ((res ad-return-value))
    (if (and (listp res)
             (stringp (car res))
             (cdr res)) ; length > 1, don't ignore sole match
        (setq ad-return-value
              (completion-pcm--filename-try-filter res)))))

(prefer-coding-system 'euc-jp)
(prefer-coding-system 'utf-8)
(prefer-coding-system 'utf-8-unix)

(add-hook 'c-mode-common-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq comment-column 40)
            (c-set-offset 'substatement-open '0)
            (c-set-offset 'case-label '+)
            (c-set-offset 'arglist-intro '+)
            (c-set-offset 'arglist-close 0)
            (setq show-trailing-whitespace t)))

(setq-default indent-tabs-mode nil)
(custom-set-variables '(c-basic-offset 4))
