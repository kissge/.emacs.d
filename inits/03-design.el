(setq frame-title-format (concat "%b - Emacs " emacs-version))

(show-paren-mode 1)
(custom-set-variables '(show-paren-style 'expression))

(defun find-first-member (ls candidates)
  (if candidates
      (if (member (car candidates) ls)
          (car candidates)
        (find-first-member ls (cdr candidates)))))

(custom-set-faces
 '(default ((t (:background "black" :foreground "white" :height 98
                :family (find-first-member (font-family-list) '("MonacoB" "Monaco"))))))
 '(completions-common-part ((t (:inherit default :foreground "red"))))
 '(diredp-compressed-file-suffix ((t (:foreground "#7b68ee"))))
 '(diredp-ignored-file-name ((t (:foreground "#aaaaaa"))))
 '(isearch ((t (:background "black" :foreground "white"))))
 '(show-paren-match ((t (:foreground "steelblue3")))))
(set-face-background 'trailing-whitespace "purple4")
(custom-set-variables '(show-trailing-whitespace t))
(defface mixed-tab-and-space-face '((t (:background "purple4"))) nil :group 'original)
(defface tab-face '((t (:strike-through t :foreground "#202020"))) nil :group 'original)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords major-mode '(("\\(// \\)?[tT][oO][dD][oO]:.*[\r\n]?" 0 'highlight append)))
  (if (or buffer-read-only (memq major-mode '(shell-mode diff-mode)))
      (setq show-trailing-whitespace nil)
    (font-lock-add-keywords major-mode '(("^[ \t]* \t" 0 'mixed-tab-and-space-face append)) t)
    (font-lock-add-keywords major-mode '(("\t+" 0 'tab-face append)) t)) )
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
(add-hook 'find-file-hooks '(lambda () (if font-lock-mode nil (font-lock-mode t))))

(el-get-bundle! milkypostman/powerline
  ;; bad hack :( ... see https://github.com/milkypostman/powerline/issues/54
  (custom-set-variables '(ns-use-srgb-colorspace nil))

  (defface powerline-active1-tramp '((t (:inherit mode-line))) "" :group 'powerline)
  (defface powerline-active2-tramp '((t (:inherit mode-line))) "" :group 'powerline)
  (set-face-attribute 'mode-line nil
                      :foreground "#fff" :background "#5B0000" :box nil)
  (set-face-attribute 'powerline-active1 nil
                      :foreground "#fff" :background "#810000" :inherit 'mode-line)
  (set-face-attribute 'powerline-active2 nil
                      :foreground "#fff" :background "#AA0000" :inherit 'mode-line)
  (set-face-attribute 'powerline-active1-tramp nil
                      :foreground "#fff" :background "#506150" :inherit 'mode-line)
  (set-face-attribute 'powerline-active2-tramp nil
                      :foreground "#fff" :background "#509A50" :inherit 'mode-line)
  (setq-default
   mode-line-format
   '("%e"
     (:eval
      (let* ((active (powerline-selected-window-active))
             (file (or buffer-file-name dired-directory list-buffers-directory))
             (remote (and file (file-remote-p file)))
             (mode-line (if active 'mode-line 'mode-line-inactive))
             (face1 (if active (if remote 'powerline-active1-tramp 'powerline-active1) 'powerline-inactive1))
             (face2 (if active (if remote 'powerline-active2-tramp 'powerline-active2) 'powerline-inactive2))
             (separator-left (intern (format "powerline-%s-%s"
                                             powerline-default-separator
                                             (car powerline-default-separator-dir))))
             (separator-right (intern (format "powerline-%s-%s"
                                              powerline-default-separator
                                              (cdr powerline-default-separator-dir))))
             (lhs (list (powerline-raw "%*" nil 'l)
                        (powerline-raw mode-line-mule-info nil 'l)
                        (powerline-raw (if remote "[%3l" "(%3l"))
                        (powerline-raw ",")
                        (powerline-raw (if remote "%3c]" "%3c)"))
                        (powerline-buffer-id nil 'l)
                        (when (and (boundp 'which-func-mode) which-func-mode)
                          (powerline-raw which-func-format nil 'l))
                        (powerline-raw " ")
                        (funcall separator-left mode-line face1)
                        (when (boundp 'erc-modified-channels-object)
                          (powerline-raw erc-modified-channels-object face1 'l))
                        (powerline-major-mode face1 'l)
                        (powerline-process face1)
                        (powerline-minor-modes face1 'l)
                        (powerline-narrow face1 'l)
                        (powerline-raw " " face1)
                        (funcall separator-left face1 face2)
                        (powerline-vc face2 'r)))
             (rhs (list (powerline-raw global-mode-string face2 'r)
                        (funcall separator-right face2 face1)
                        (powerline-buffer-size face1 'l)
                        (powerline-raw " " face1)
                        (funcall separator-right face1 mode-line)
                        (powerline-raw " ")
                        (powerline-raw "%6p" nil 'r)
                        )))
        (if (and active remote)
            (let ((hue (/ (string-to-number (substring (md5 remote) -4) 16) 65536.0)))
              (set-face-background 'powerline-active1-tramp (apply 'color-rgb-to-hex (color-hsl-to-rgb hue .7 .2)))
              (set-face-background 'powerline-active2-tramp (apply 'color-rgb-to-hex (color-hsl-to-rgb hue .7 .4)))
              (powerline-reset)))
        (concat (powerline-render lhs)
                (powerline-fill face2 (powerline-width rhs))
                (powerline-render rhs)))))))

(el-get-bundle! mode-icons
  (mode-icons-mode))
