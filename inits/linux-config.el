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
