;;; +company.el -*- lexical-binding: t; -*-
(after! company
  (setq company-idle-delay 0.5
        company-minimum-prefix-length 2))

(set-company-backend!
  '(text-mode
    markdown-mode)
  '(:separate
    company-ispell
    company-yasnippet
    company-files))
