;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Luis Dale Gascon"
      user-mail-address "luis.gcodes@gmail.com")

(setq doom-font (font-spec :family "Hack Nerd Font" :size 12 :height 1.0)
      ;; doom-big-font (font-spec :family "ETBembo" :size 20)
      doom-serif-font (font-spec :family "Input Serif" :size 15)
      doom-unicode-font (font-spec :family "JuliaMono")
      doom-variable-pitch-font (font-spec :family "Alegreya" :size 15))

;; UI
(setq
 ;; (Optional) Project / Buffer titlebar
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

 ;; Misc. UI changes.
 doom-theme 'doom-badger
 emojify-emoji-set "twemoji-v2"
 display-line-numbers-type 'relative
 truncate-string-ellipsis "…"
 ;; Snippets inside snippets
 yas-triggers-in-field t
 ;; Visiting backlinks should overwrite the current roam window
 pop-up-windows nil
 +format-on-save-enabled-modes t
 )
(setf dired-kill-when-opening-new-dired-buffer t)
(setq-default fill-column 90)

(cond (IS-MAC
       ;; Transparent titlebar.
       (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
       (add-to-list 'default-frame-alist '(ns-appearance . dark))
       ;; I don't think this works
       (setq mac-right-option-modifier 'alt)
       (setq +latex-viewers '(skim))))

;; Zen mode
(setq +zen-text-scale 1.2)

;; Enabled modes
;; Overwrites selected text when pasting
(delete-selection-mode 1)
;; Scroll up and down vertico candidates
(vertico-mouse-mode 1)

;; Disable Tetris high score buffer
(defadvice tetris-end-game (around zap-scores activate)
  (save-window-excursion ad-do-it))

;; Prompt for buffer when splitting
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package! mixed-pitch
  :hook (org-mode . mixed-pitch-mode)
  :config
  (setq mixed-pitch-set-heigth t)
  (set-face-attribute 'variable-pitch nil :height 2.0))

(after! heaven-and-hell
  (setq
   ;; Toggle light/dark theme
   heaven-and-hell-load-theme-no-confirm t
   heaven-and-hell-theme-type 'dark
   heaven-and-hell-themes
   '((light . modus-operandi)
     (dark . doom-horizon))))

;; NeoTree
(after! neotree
  (setq doom-themes-neotree-enable-variable-pitch nil
        doom-themes-neotree-line-spacing 1
        doom-themes-neotree-file-icons t))

(after! text-mode
  (set-company-backend! 'company-ispell nil))

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

;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! lsp-ui
  (setq lsp-ui-sideline-enable t
        lsp-ui-sideline-show-code-actions t
        lsp-ui-sideline-show-diagnostics t
        lsp-ui-sideline-show-hover nil
        lsp-log-io nil
        lsp-lens-enable t ; not working properly with ccls!
        lsp-diagnostics-provider :auto
        lsp-enable-symbol-highlighting t
        lsp-headerline-breadcrumb-enable nil
        lsp-headerline-breadcrumb-segments '(symbols)))

(after! dap-mode
  (setq dap-python-debugger 'debugpy))

(add-hook 'after-change-major-mode-hook
          #'doom-modeline-conditional-buffer-encoding)

;; Let heaven-and-hell load theme
(add-hook 'after-init-hook
          'heaven-and-hell-init-hook)

;; Pretty info
(add-hook 'Info-selection-hook
          'info-colors-fontify-node)

(remove-hook! 'text-mode-hook
  #'display-line-numbers-mode
  #'vi-tilde-fringe-mode)

;; (load! "+centaur"
;; (load! "+treemacs")
(load! "+which-key")
(load! "+projectile")
(load! "+dashboard")
(load! "+bindings")
(load! "+org-modern")
(load! "+modeline")
(load! "+org")
(load! "+deft")
(load! "+company.el")

t; Emacs plus specific
;; (defun my/apply-theme (appearance)
;;   "Load theme, taking current system APPEARANCE into consideration."
;;   (mapc #'disable-theme custom-enabled-themes)
;;   (pcase appearance
;;     ('light (load-theme modus-operandi t))
;;     ('dark (load-theme doom-badger t))))

;; (add-hook 'ns-system-appearance-change-functions #'my/apply-theme)
