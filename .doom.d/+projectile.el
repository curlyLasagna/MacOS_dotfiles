;;; +projectile.el -*- lexical-binding: t; -*-
(setq projectile-ignored-projects '("~/"
                                    "/tmp"
                                    "~/.emacs.d/"
                                    "~/.emacs.d/.local/straight/repos/"
                                    "/opt/homebrew"))
(defun projectile-ignored-project-function (filepath)
  "Return t if FILEPATH is within any of `projectile-ignored-projects'"
  (or (mapcar (lambda (p) (s-starts-with-p p filepath)) projectile-ignored-projects)))
