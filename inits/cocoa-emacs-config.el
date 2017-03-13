(ns-toggle-toolbar)
(custom-set-variables '(mac-command-modifier 'meta)
                      '(frame-inherited-parameters '(tool-bar-lines)))
(let* ((nonsense "@@@PATH@@@")
       (path-raw (shell-command-to-string (concat "$SHELL -lic 'echo " nonsense "${PATH}" nonsense "'")))
       (path-trimmed (cadr (split-string path-raw nonsense)))
       (path-separated (split-string path-trimmed path-separator)))
  (setenv "PATH" path-trimmed)
  (setq exec-path path-separated))

(defun open-terminal-here ()
  (interactive)
  (shell-command "open -a iTerm ."))

(set-fontset-font "fontset-default" 'japanese-jisx0208 '("Hiragino Kaku Gothic ProN" . "iso10646-1"))
(set-fontset-font "fontset-default" 'katakana-jisx0201 '("Hiragino Kaku Gothic ProN" . "iso10646-1"))
