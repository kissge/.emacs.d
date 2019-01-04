(defconst env-wsl (and (string-match-p "Microsoft" (shell-command-to-string "uname -r")) t))

(tool-bar-mode 0)
(menu-bar-mode 0)

(global-set-key (kbd "<C-next>") 'other-window)
(global-set-key (kbd "<C-prior>") 'other-window-prev)

(el-get-bundle! mozc
  :type http
  :url "https://raw.githubusercontent.com/google/mozc/master/src/unix/emacs/mozc.el"
  (setq default-input-method "japanese-mozc")
  (global-set-keys 'toggle-input-method
                   (kbd "s-SPC") (kbd "<zenkaku-hankaku>")))
(el-get-bundle! pos-tip)

(defun open-terminal-here ()
  (interactive)
  (shell-command "gnome-terminal ."))

(set-fontset-font "fontset-default" 'japanese-jisx0208 '("Noto Sans CJK JP Medium" . "iso10646-1"))
(set-fontset-font "fontset-default" 'katakana-jisx0201 '("Noto Sans CJK JP Medium" . "iso10646-1"))

(when env-wsl
  (let* ((nonsense "@@@PATH@@@")
         (path-raw (shell-command-to-string (concat "$SHELL -lic 'echo " nonsense "${PATH}" nonsense "'")))
         (path-trimmed (cadr (split-string path-raw nonsense)))
         (path-separated (split-string path-trimmed path-separator)))
    (setenv "PATH" path-trimmed)
    (setq exec-path path-separated))
  (custom-set-variables '(browse-url-generic-program "/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe")
                        '(browse-url-browser-function 'browse-url-generic))

  (global-set-key
   (kbd "C-x !")
   (defun open-filer-here ()
     (interactive)
     (shell-command
      (concat
       "explorer.exe \""
       (shell-command-to-string
        (concat "printf %s \"$(wslpath -w \"" default-directory "\")\""))
       "\""))))

  ;; fix for bug on WSL; tramp-mode hangs while saving
  (custom-set-variables '(tramp-chunksize 1024)))
