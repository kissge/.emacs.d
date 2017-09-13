(when env-hikarie
  (setq-default tags-file-name "/eng4:TAGS")
)

(when env-ms
  (el-get-bundle msbuild-mode in kissge/emacs-msbuild-mode)

  (custom-set-faces '(default ((t (:height 85)))))
  (prefer-coding-system 'utf-8-dos)
  (custom-set-variables '(nxml-child-indent 4)
                        '(require-final-newline nil)
                        '(mode-require-final-newline nil))
  (add-hook 'c-mode-common-hook
            (defun c-mode-ms-coding-convention ()
              (c-set-offset 'innamespace 0)))
  (setq auto-mode-alist
        (append '(("\\.uix$" . xml-mode)
                  ("\\.dm$" . xml-mode)
                  ("\\.ds$" . xml-mode)
                  ("/\\([Mm]akefil0\\|sources\\)\\'" . makefile-mode)
                  ("\\.inc\\'" . makefile-mode)
                  )
                auto-mode-alist))
  (global-set-key
   (kbd "C-x ,")
   (defun git-add-force-this-file ()
     (interactive)
     (shell-command (concat "git add -f \"" (buffer-file-name) "\""))))

  (add-hook 'find-file-hook
          (defun set-buffer-theme-color-seed-to-repository-path ()
            (if (and (buffer-file-name) (string-match "\\(.*?/src\\)/" (buffer-file-name)))
                (let ((sdxroot (match-string-no-properties 1 (buffer-file-name))))
                  (when (file-directory-p (concat sdxroot ".out"))
                    (setq-local buffer-root-directory (concat sdxroot "/"))
                    (setq-local buffer-theme-color-seed sdxroot))))))
  )
