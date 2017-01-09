(el-get-bundle company-php in xcwen/ac-php
  :name company-php
  :depends (s f xcscope yasnippet php-mode popup))
(el-get-bundle php-mode)
(el-get-bundle! flymake-cursor)
(el-get-bundle arnested/php-extras)
(el-get-bundle! flymake-phpcs
  :type github :pkgname "illusori/emacs-flymake-phpcs"
  (custom-set-variables
   `(flymake-phpcs-command ,(and (executable-find "phpcs")
                                 (executable-find (concat el-get-dir "/flymake-phpcs/bin/flymake_phpcs"))))
   '(flymake-phpcs-standard "Symfony2")
   '(flymake-phpcs-show-rule t))
  (add-hook 'php-mode-hook
            '(lambda ()
               (eldoc-mode)
               (define-key php-mode-map [tab] nil) ; re-enable tab completion
               (if (executable-find "phpcs")
                   (let ((mode-and-masks (flymake-get-file-name-mode-and-masks "example.php")))
                     (setcar mode-and-masks 'flymake-phpcs-init)))
               (php-enable-symfony2-coding-style)
               (setq show-trailing-whitespace t))))
(el-get-bundle gist:05d736b37f1d726a38807061d9fb6232:php-doc
 (custom-set-variables '(php-insert-doc-access-tag nil))
  (add-hook 'php-mode-hook
            (defun php-mode-php-doc-hook ()
             (local-set-key (kbd "M-P") 'php-insert-doc-block))))
(el-get-bundle js2-mode
  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
  (custom-set-variables '(js2-global-externs '("$" "location" "setInterval" "setTimeout" "clearTimeout" "clearInterval"))))
(el-get-bundle yaml-mode
  (setq-default yaml-indent-offset 4)
  (add-hook 'yaml-mode-hook (lambda () (setq require-final-newline t))))
(el-get-bundle scss-mode
  (add-hook 'scss-mode-hook (lambda () (setq require-final-newline t))))

(el-get-bundle web-mode
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.twig\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode)))

(custom-set-variables '(sgml-basic-offset 4))
