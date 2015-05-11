(defun global-set-keys (command &rest keys)
  (dolist (key keys)
    (global-set-key key command)))

(custom-set-variables '(cua-mode t nil (cua-base))
                      '(select-active-regions nil)) ; for clipboard

(defun compile-in-background (command &optional comint)
  (interactive
   (list
    (let ((command (eval compile-command)))
      (if (or compilation-read-command current-prefix-arg)
          (compilation-read-command command)
        command))
    (consp current-prefix-arg)))
  (save-window-excursion
    (compile command comint)))
(defun recompile-in-background ()
  (interactive)
  (save-window-excursion
    (recompile)))
(global-set-key [f5] 'recompile-in-background)
(global-set-key [f6] 'compile-in-background)
(global-set-key [f7] 'shell)

(defun other-window-prev ()
  (interactive)
  (other-window -1))
(global-set-key [C-tab] 'other-window)
(global-set-keys 'other-window-prev (kbd "<C-S-tab>") (kbd "<C-S-iso-lefttab>"))
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key "\C-j" 'newline)

(require 'subword)
(global-set-keys 'subword-backward (kbd "<M-left>") (kbd "<A-left>") (kbd "<XF86Back>"))
(global-set-keys 'subword-forward (kbd "<M-right>") (kbd "<A-right>") (kbd "<XF86Forward>"))
(global-subword-mode 1)

(defun delete-backward-word ()
  (interactive)
  (let ((from (point)))
    (subword-backward 1)
    (delete-region from (point))))

(defun delete-forward-word ()
  (interactive)
  (let ((from (point)))
    (subword-forward 1)
    (delete-region from (point))))

(global-set-keys 'delete-backward-word (kbd "<C-backspace>") (kbd "<M-backspace>"))
(global-set-keys 'delete-forward-word (kbd "<C-delete>") (kbd "<C-kp-delete>") (kbd "<M-kp-delete>"))

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(define-key ctl-x-4-map "t" 'toggle-window-split)

;; http://emacs.wordpress.com/2007/01/17/eval-and-replace-anywhere/
(defun fc-eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))
(global-set-key (kbd "C-c e") 'fc-eval-and-replace)

(global-set-key (kbd "<home>") 'move-beginning-of-line)
(global-set-key (kbd "<end>") 'move-end-of-line)
(global-set-key (kbd "<M-up>") 'beginning-of-buffer)
(global-set-key (kbd "<M-down>") 'end-of-buffer)

;; https://gist.github.com/mads379/3402786
(defun toggle-maximize-buffer () "Maximize buffer"
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_)
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))
(global-set-key (kbd "C-^") 'toggle-maximize-buffer)

(global-unset-key (kbd "M-c"))
(global-unset-key (kbd "C-x C-z"))
(defun copy-filename ()
  (interactive)
  (let* ((name (buffer-file-name))
         (name (or (file-remote-p name 'localname) name)))
    (kill-new name)
    (message (concat "Copied \"" name "\" to clipboard."))))
(global-set-key (kbd "C-x C-z") 'copy-filename)

(global-set-key (kbd "M-U") 'revert-buffer)
(global-set-key (kbd "M-N") 'normal-mode)

(fset 'delete-eol-and-indent [down ?\M-m S-up S-end ? ])
(global-set-key (kbd "<S-kp-delete>") 'delete-eol-and-indent)

(defun beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e "python -mjson.tool" (current-buffer) t)))

(el-get-bundle string-inflection
  (with-eval-after-load-feature 'string-inflection
    (defun string-inflection-my-style-cycle ()
      (interactive)
      (insert (let ((str (string-inflection-get-current-word)))
                (if (string-inflection-lower-camelcase-p str)
                    (string-inflection-underscore-function str)
                  (string-inflection-lower-camelcase-function str))))))
  (autoload 'string-inflection-my-style-cycle "string-inflection")
  (global-set-key (kbd "C-x C-a") 'string-inflection-my-style-cycle))
