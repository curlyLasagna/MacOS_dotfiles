;;; +company.el -*- lexical-binding: t; -*-
(after! company
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 3
        company-selection-wrap-around t
        company-ispell-available nil
        company-tooltip-limit 5
        company-tooltip-minimum 3
        company-tooltip-flip-when-above t
        company-dabbrev-ignore-case 'keep-prefix
        company-preview-overlay t
        company-files-exclusions '(".DS_Store" ".git"))
        (setq company-show-quick-access t)
        (setq company-box-doc-no-wrap nil)

  ;; (set-company-backend!
  ;;   '(text-mode
  ;;     markdown-mode)
  ;;   '(:separate
  ;;     company-ispell
  ;;     company-yasnippet
  ;;     company-files
  ;;     company-dabbrev))
  ;; (set-company-backend!
  ;;   '(prog-mode)
  ;;   '(:separate
  ;;     company-files
  ;;     company-dabbrev-code
  ;;     company-dabbrev
  ;;     ))

  ;; https://abdelhakbougouffa.pro/posts/config/#tweaks
  ;; Disable company in these modes
  (setq company-global-modes
        '(not erc-mode
          circe-mode
          message-mode
          help-mode
          gud-mode
          vterm-mode
          )))

(map!
 (:after company
  (:map company-active-map
   ;; Don't interfere with `evil-delete-backward-word' in insert mode
   "C-w"        nil

   ;; Navigate candidates
   "C-j"        #'company-other-backend
   "C-k"        #'company-other-backend
   "C-l"        #'company-complete-selection
   "C-SPC"      #'company-complete-common
   [escape]     (λ! (company-abort) (evil-normal-state 1))

   ;; filter or show docs for candidate
   "C-h"        #'company-show-doc-buffer)))
