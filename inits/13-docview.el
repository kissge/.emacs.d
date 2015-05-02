(eval-when-compile (require 'doc-view))
(add-hook 'doc-view-mode-hook
          (lambda ()
            (define-key doc-view-mode-map (kbd "j") 'doc-view-next-page)
            (define-key doc-view-mode-map (kbd "k") 'doc-view-previous-page)))
