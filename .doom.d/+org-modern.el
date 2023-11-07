;;; org-modern.el -*- lexical-binding: t; -*-

(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star ["◉" "○" "✸" "◆""✤" "✜" "✿" "▶"]
        org-modern-table-vertical 1
        org-modern-table-horizontal 0.2
        org-modern-list '((43 . "➤")
                          (45 . "–")
                          (42 . "•"))
        org-modern-footnote
        (cons nil (cadr org-script-display))
        org-modern-progress nil
        org-modern-priority nil)
  (custom-set-faces! '(org-modern-statistics :inherit org-checkbox-statistics-todo)))
