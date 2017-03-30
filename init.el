(setq gc-cons-threshold 134217728)

(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(let ((versioned-dir (locate-user-emacs-file (format ".v%s" emacs-version))))
  (setq-default el-get-dir (expand-file-name "el-get" versioned-dir)
                package-user-dir (expand-file-name "elpa" versioned-dir)))

(add-to-list 'load-path (expand-file-name "el-get" el-get-dir))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(defun global-set-keys (command &rest keys)
  (dolist (key keys)
    (global-set-key key command)))

(el-get-bundle kissge/init-loader
  (custom-set-variables '(init-loader-show-log-after-init 'error-only)
                        '(init-loader-order 'platform-specific-first))
  (init-loader-load))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)
