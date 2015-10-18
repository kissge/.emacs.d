(tool-bar-mode 0)
(menu-bar-mode 0)

(global-set-key (kbd "<C-next>") 'other-window)
(global-set-key (kbd "<C-prior>") 'other-window-prev)

(el-get-bundle! mozc
  :type http
  :url "https://mozc.googlecode.com/svn/trunk/src/unix/emacs/mozc.el"
  (setq default-input-method "japanese-mozc")
  (global-set-key (kbd "s-SPC") 'toggle-input-method))
(el-get-bundle! pos-tip)
