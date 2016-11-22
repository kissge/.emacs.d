(fset 'yes-or-no-p 'y-or-n-p)
(custom-set-variables '(read-file-name-completion-ignore-case t))
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(mapc
 (lambda (args)
   (add-hook (car args)
             `(lambda ()
                (unless (or (file-exists-p "makefile")
                            (file-exists-p "Makefile")
                            (not buffer-file-name))
                  (set (make-local-variable 'compile-command)
                       (concat ,(cdr args) " -Wall " (file-name-nondirectory buffer-file-name)
                               " -o " (file-name-sans-extension (file-name-nondirectory buffer-file-name))))))))
 '((c-mode-hook . "gcc") (c++-mode-hook . "g++")))

(add-hook 'before-save-hook
          (lambda ()
            (when buffer-file-name
              (let ((dir (file-name-directory buffer-file-name)))
                (when (and (not (file-exists-p dir))
                           (y-or-n-p (format "Directory %s does not exist. Create it? " dir)))
                  (make-directory dir t))))))

(defun display-compile-buffer-if-failed (buffer string)
  (if (and (string-match "compilation" (buffer-name buffer))
           (or ;; (with-current-buffer buffer (search-forward "warning" nil t))
            (not (string-match "finished" string))))
      (display-buffer buffer)))

(add-hook 'compilation-finish-functions 'display-compile-buffer-if-failed)

;; bad hack: force backup file to be saved in the local directory in tramp-mode
;; This behavior possibly leads to a problem when using `su' or `sudo'
(autoload 'tramp-run-real-handler "tramp" "" nil '(operation args))
(with-eval-after-load-feature 'tramp
  (defun tramp-handle-find-backup-file-name (filename)
    (with-parsed-tramp-file-name filename nil
      (let ((backup-directory-alist backup-directory-alist))
        (tramp-run-real-handler 'find-backup-file-name (list filename))))))

(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)

(defun electric-pair-my-heuristic-inhibit (char)
  ;; insert nothing if the following char is alphabet, number, "_", "(", or "["
  (or (looking-at-p "[[:alnum:]_(\[]")
      (electric-pair-default-inhibit char)))
(custom-set-variables '(electric-pair-inhibit-predicate #'electric-pair-my-heuristic-inhibit))
(electric-pair-mode)
