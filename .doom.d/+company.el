;;; +company.el -*- lexical-binding: t; -*-
(after! company
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 2
        company-selection-wrap-around t
        company-tooltip-limit 20
        company-tooltip-minimum 6
        company-tooltip-flip-when-above 'nil
        company-tooltip-maximum-width 120
        company-tooltip-minimum-width 30
        company-show-quick-access 't
        )

  ;; https://abdelhakbougouffa.pro/posts/config/#tweaks
  ;; Disable company in these modes
  (setq company-global-modes
        '(not erc-mode
          circe-mode
          message-mode
          help-mode
          gud-mode
          vterm-mode
          org-journal-mode
          )))

(map!
 (:after company
         (:map company-active-map
               ;; Navigate candidates
               "C-j"        #'company-other-backend
               ;; [escape]     (λ! (company-abort) (evil-normal-state 1))
               ;; filter or show docs for candidate
               "C-h"        #'company-show-doc-buffer)))
