;;; +company.el -*- lexical-binding: t; -*-
(after! company
  (setq company-idle-delay .1
        company-minimum-prefix-length 2
        company-selection-wrap-around t
        company-ispell-available nil))

(setq company-show-quick-access t)

;; (set-company-backend!
;;   '(text-mode
;;     markdown-mode)
;;   '(:separate
;;     company-ispell
;;     company-yasnippet
;;     company-files))

;; https://abdelhakbougouffa.pro/posts/config/#tweaks
;; Disable company mode
(setq company-global-modes
      '(not erc-mode
            circe-mode
            message-mode
            help-mode
            gud-mode
            vterm-mode
            ))
