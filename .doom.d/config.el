;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Luis Dale Gascon"
      user-mail-address "luis.gcodes@gmail.com")

;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
(setq doom-font (font-spec :family "Hack Nerd Font" :size 12)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans Mono" :size 12)
      doom-serif-font (font-spec :family "Gill Sans" :size 12))

;; doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; UI
(setq
 ;; (Optional) Project / Buffer titlebar title
 frame-title-format
 '(""
   (:eval
    (if (s-contains-p org-roam-directory (or buffer-file-name ""))
        (replace-regexp-in-string
         ".*/[0-9]*-?" "☰ "
         (subst-char-in-string ?_ ?  buffer-file-name))
      "%b"))
   (:eval
    (let ((project-name (projectile-project-name)))
      (unless (string= "-" project-name)
        (format (if (buffer-modified-p)  " ◉ %s" "  ●  %s") project-name)))))

 ;; Misc. UI changes. Nothing important
 emojify-emoji-set "twemoji-v2"
 doom-theme 'doom-horizon
 fancy-splash-image (concat doom-private-dir "dashBanners/pngegg-2.png")
 display-line-numbers-type 'relative
 truncate-string-ellipsis "…"
 heaven-and-hell-theme-type 'dark
 heaven-and-hell-themes
 '((light . doom-homage-white)
   (dark . doom-dracula))
 heaven-and-hell-load-theme-no-confirm t
 )

;; Transparent titlebar.
;; 
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
;; Zen mode
(setq +zen-text-scale 0.1)

;; modeline
;; ;; Add padding to the right modeline
(after! doom-modeline
  (setq doom-modeline-major-mode-color-icon t
  find-file-visit-truename t
  doom-modeline-gnus nil
  all-the-icons-scale-factor 1.1)
  (doom-modeline-def-modeline 'main
    '(bar matches buffer-info remote-host buffer-position parrot selection-info)
    '(misc-info minor-modes checker input-method buffer-encoding major-mode process vcs "  "))) ; <-- added padding here

;; org
(setq org-directory "~/org/"
      org-roam-directory (concat org-directory "roam/"))
(org-roam-db-autosync-mode)
;; rhs of the alist represents the bullet when it's demoted
(setq org-list-demote-modify-bullet '(("+" . "-") ("-" . "+") ("*" . "+") ("1." . "a.")))
(setq org-image-actual-width (list 420))

;; Org mode hooks
(add-hook! 'org-mode-hook
           #'my-org-latex-yas 'auto-fill-mode #'+org-pretty-mode #'mixed-pitch-mode)

;; Narrower compared to default
;; Appears on the left
;; Appears as a side window
(add-to-list 'display-buffer-alist
             '("\\*org-roam\\*"
               (display-buffer-in-side-window)
               (side . left)
               (slot . 0)
               (window-width . 0.25)
               (window-parameters . ((no-other-window . t)
                                     (no-delete-other-windows . t)))))

(custom-set-faces!
  '(outline-1 :weight extra-bold :height 1.25)
  '(outline-2 :weight bold :height 1.15)
  '(outline-3 :weight bold :height 1.12)
  '(outline-4 :weight semi-bold :height 1.09)
  '(outline-5 :weight semi-bold :height 1.06)
  '(outline-6 :weight semi-bold :height 1.03)
  '(outline-8 :weight semi-bold)
  '(outline-9 :weight semi-bold))
(custom-set-faces!
  '(org-document-title :height 1.2))

;; treesitter
(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
  )

;; Disable Tetris high score buffer
(defadvice tetris-end-game (around zap-scores activate)
  (save-window-excursion ad-do-it))

;; Prompt for buffer when splitting
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))

(defun my-org-latex-yas ()
  "Activate org and LaTeX yas expansion in org-mode buffers."
  (yas-minor-mode)
  (yas-activate-extra-mode 'latex-mode))

;; Switch back to the original buffer after inserting a node
;; compared to switching to the inserted node
(defun org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (cons arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))

;; Org roam modeline title that makes sense
;; (date) <file name>
(defadvice! doom-modeline--buffer-file-name-roam-aware-a (orig-fun)
  :around #'doom-modeline-buffer-file-name ; takes no args
  (if (s-contains-p org-roam-directory (or buffer-file-name ""))
      (replace-regexp-in-string
       "\\(?:^\\|.*/\\)\\([0-9]\\{4\\}\\)\\([0-9]\\{2\\}\\)\\([0-9]\\{2\\}\\)[0-9]*-"
       "(\\1-\\2-\\3) "
       (subst-char-in-string ?_ ?  buffer-file-name))
    (funcall orig-fun)))

;; org-roam-ui settings
(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(remove-hook! 'text-mode-hook
  #'display-line-numbers-mode)

(setq org-journal-time-format "%I:%M %p")

(setq +latex-viewers '(skim))

;; Overwrites selected text when pasting
(setq delete-selection-mode 1)

(dolist (mode '(dired-mode ibuffer-mode)))
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(use-package! mixed-pitch
  :hook (org-mode . mixed-pitch-mode)
  :config
  (setq mixed-pitch-set-heigth t)
  (set-face-attribute 'variable-pitch nil :height 1.3))

(use-package! dirvish)
(setq dirvish-override-dired-mode t)

(defadvice! yeet/org-roam-in-own-workspace-a (&rest _)
  "Open all roam buffers in there own workspace."
  :before #'org-roam-node-find
  :before #'org-roam-node-random
  :before #'org-roam-buffer-display-dedicated
  :before #'org-roam-buffer-toggle
  (when (featurep! :ui workspaces)
    (+workspace-switch "*roam*" t)))

;; NeoTree themes
;; classic, ascii, arrow, icons, nerd
(after! neotree
  (setq neo-theme 'nerd))
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with

;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; (load! "+centaur")
;; (load! "+treemacs")
(load! "+which-key")
(load! "+projectile")
(load! "+bindings")
(load! "+org-modern")
