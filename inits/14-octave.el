(setq auto-mode-alist (cons '("\\.m$" . octave-mode) auto-mode-alist))

;; (el-get-bundle cl-generic) ???

;; (el-get-bundle ein) <- auto-complete ... :(

;; (add-hook 'ein:notebook-multilang-mode-hook
;;           (defun ein:notebook-multilang-mode-my-hook ()
;;             (local-set-key (kbd "<S-return>") (defun ein-shift-return ()
;;                                                 (interactive)
;;                                                 (call-interactively 'ein:worksheet-execute-cell)
;;                                                 (call-interactively 'ein:worksheet-insert-cell-below)))))

;; ;; (autoload 'ein:worksheet-execute-cell-and-insert-below "ein-worksheet" "" t nil)
;; (autoload 'ein:notebook-multilang-mode-map "ein-multilang" "" t 'keymap)
;; (define-key ein:notebook-multilang-mode-map (kbd "<S-return>") 'ein:worksheet-execute-cell-and-insert-below)
