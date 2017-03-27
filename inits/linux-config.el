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
