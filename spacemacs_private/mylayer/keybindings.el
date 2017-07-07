;; Basic Key Bindings
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-t") 'other-window)
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "M-{") 'scroll-down-in-place)
(global-set-key (kbd "M-}") 'scroll-up-in-place)
(when (eq system-type 'darwin)
  (setq ns-command-modifier (quote meta)))
(setq set-mark-command-repeat-pop t)

;; auto-complete
(setq ac-use-menu-map t) ;; 補完候補を C-n/C-p で選択
(global-set-key (kbd "M-/") 'auto-complete)
