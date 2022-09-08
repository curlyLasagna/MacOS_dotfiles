;;; org-modern.el -*- lexical-binding: t; -*-

(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star ["◉" "○" "✸" "✿" "✤" "✜" "◆" "▶"]
        org-modern-table-vertical 1
        org-modern-table-horizontal 0.2
        org-modern-list '((43 . "➤")
                          (45 . "–")
                          (42 . "•"))
        ;; org-modern-todo-faces
        ;; '(("TODO" :inverse-video t :inherit org-todo)
        ;;   ("PROJ" :inverse-video t :inherit +org-todo-project)
        ;;   ("STRT" :inverse-video t :inherit +org-todo-active)
        ;;   ("[-]"  :inverse-video t :inherit +org-todo-active)
        ;;   ("HOLD" :inverse-video t :inherit +org-todo-onhold)
        ;;   ("WAIT" :inverse-video t :inherit +org-todo-onhold)
        ;;   ("[?]"  :inverse-video t :inherit +org-todo-onhold)
        ;;   ("KILL" :inverse-video t :inherit +org-todo-cancel)
        ;;   ("NO"   :inverse-video t :inherit +org-todo-cancel))
        org-modern-footnote
        (cons nil (cadr org-script-display))
        org-modern-progress nil
        org-modern-priority nil)
  (custom-set-faces! '(org-modern-statistics :inherit org-checkbox-statistics-todo)))
