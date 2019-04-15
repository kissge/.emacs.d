(defconst env-hikarie (string-match-p "^vmac" system-name))
(defconst env-ms (file-directory-p "C:/git/os"))

(setq make-backup-files t)
(setq backup-directory-alist
      `(("." . ,(locate-user-emacs-file ".backup/")) . ,backup-directory-alist))
(setq auto-save-file-name-transforms
      `((".*" ,(locate-user-emacs-file ".backup/") t)))
(setq create-lockfiles nil)

(custom-set-variables `(tramp-persistency-file-name ,(locate-user-emacs-file ".tramp"))
                      '(tramp-backup-directory-alist backup-directory-alist)
                      `(tramp-auto-save-directory ,(locate-user-emacs-file ".backup/"))
                      '(tramp-use-ssh-controlmaster-options nil)
                      '(tramp-default-proxies-alist '(((regexp-quote (system-name)) nil nil)
                                                      ("localhost" nil nil)
                                                      (nil "\\`root\\'" "/ssh:%h:")))
                      '(auto-save-interval 100)
                      '(auto-save-timeout 10)
                      `(auto-save-list-file-prefix ,(concat user-emacs-directory ".auto-save-list/.saves-"))
                      `(url-configuration-directory ,(locate-user-emacs-file ".url/")))

(setq completion-ignored-extensions
      (append completion-ignored-extensions
              '(".exe" ".com" ".out" "./" "../" ".docx" ".xlsx" "#" ".DS_Store"
                ".zip" ".tar.gz" ".tgz" "Icon\n" "TAGS" "__pycache__/" ".egg-info/")))
(defadvice completion-file-name-table (after ignoring-backups-f-n-completion activate)
  "filter out results when the have completion-ignored-extensions"
  (let ((res ad-return-value))
    (if (and (listp res)
             (stringp (car res))
             (cdr res)) ; length > 1, don't ignore sole match
        (setq ad-return-value
              (completion-pcm--filename-try-filter res)))))
(custom-set-variables '(read-buffer-completion-ignore-case t))

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

(custom-set-variables '(el-get-git-shallow-clone t))

(setq auto-mode-alist
      (append '(("\\.xaml$" . xml-mode)
                ("\\.m$" . octave-mode)
                )
              auto-mode-alist))

(custom-set-variables '(load-prefer-newer t))
