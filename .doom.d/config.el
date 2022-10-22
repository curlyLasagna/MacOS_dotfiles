;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Luis Dale Gascon"
      user-mail-address "luis.gcodes@gmail.com")

(setq doom-font (font-spec :family "Fira Code" :size 12)
      doom-variable-pitch-font (font-spec :family "ETBembo" :size 16 :height 2.0)
      doom-unicode-font (font-spec :family "Hack Nerd Font")
      doom-serif-font (font-spec :family "Input Serif" :size 16))

;; UI
(setq
 frame-title-format '("Emacs")
 emojify-emoji-set "twemoji-v2"
 ;; Alpha line numbers
 display-line-numbers-type 'relative
 truncate-string-ellipsis "…"
 ;; Trigger snippets inside snippets
 yas-triggers-in-field t
 ;; Visiting backlinks should overwrite the current roam window
 pop-up-windows nil
 ;; Supposed to use current window when editing special
 org-src-window-setup 'current-window
 ;; Auto format if possible
 +format-on-save-enabled-modes t
 visual-fill-column-width nil
 doom-fallback-buffer-name "► Doom"
 +doom-dashboard-name "► Doom"
 )
(setq doom-scratch-initial-major-mode 'emacs-lisp-mode)
(setf dired-kill-when-opening-new-dired-buffer t)
(setq-default fill-column 90)
;; https://github.com/doomemacs/doomemacs/issues/6580
;; Allow which key to show everything
(setq which-key-allow-imprecise-window-fit nil)
;; Disables spell in check in latex for performance
(setq-hook! 'LaTex-mode-hook +spellcheck-immediately nil)

(after! evil
  (setq evil-move-cursor-back nil
   evil-kill-on-visual-paste nil))

(cond (IS-MAC
       ;; Transparent titlebar.
       (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
       (add-to-list 'default-frame-alist '(ns-appearance . dark))
       (setq mac-right-option-modifier 'meta
             +latex-viewers '(skim))))

(setq +zen-text-scale 1.0)
(setq writeroom-mode-line t
      writeroom-bottom-divider-width 0)
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

;; Prevents some cases of Emacs flickering.
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; Toggle light/dark theme
(after! heaven-and-hell
  (setq
   heaven-and-hell-load-theme-no-confirm t
   heaven-and-hell-theme-type 'dark
   heaven-and-hell-themes '((light . modus-operandi)
                            (dark . doom-snazzy))))
(after! lsp-mode
  (setq lsp-enable-symbol-highlighting nil
        ;; If an LSP server isn't present when I start a prog-mode buffer, you
        ;; don't need to tell me. I know. On some machines I don't care to have
        ;; a whole development environment for some ecosystems.
        lsp-enable-suggest-server-download nil))

;; NeoTree sidebar file explorer
(after! neotree
  (setq doom-themes-neotree-enable-variable-pitch nil
        doom-themes-neotree-line-spacing 1
        doom-themes-neotree-file-icons t))

(after! text-mode
  (set-company-backend! 'company-ispell nil))

;; Aesthetically better menu when choosing what citation to insert
(setq citar-symbols
      `((file ,(all-the-icons-faicon "file-o" :face 'all-the-icons-green :v-adjust -0.1) . " ")
        (note ,(all-the-icons-material "speaker_notes" :face 'all-the-icons-blue :v-adjust -0.3) . " ")
        (link ,(all-the-icons-octicon "link" :face 'all-the-icons-orange :v-adjust 0.01) . " ")))
(setq citar-symbol-separator "  ")

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
  (setq lsp-log-io nil
        lsp-lens-enable t ; not working properly with ccls!
        lsp-diagnostics-provider :auto
        lsp-enable-symbol-highlighting t
        lsp-headerline-breadcrumb-enable nil
        ))

(add-hook 'after-change-major-mode-hook
          #'doom-modeline-conditional-buffer-encoding)

;; Let heaven-and-hell load theme
(add-hook 'after-init-hook
          'heaven-and-hell-init-hook)

;; Pretty info
(add-hook 'Info-selection-hook
          #'info-colors-fontify-node)

(add-hook 'prog-mode-hook
          #'+word-wrap-mode
          #'display-line-numbers-mode
          #'vi-tilde-fringe-mode)

(remove-hook! 'text-mode-hook
  #'vi-tilde-fringe-mode)

;; (load! "+centaur"
(load! "+which-key")
(load! "+projectile")
(load! "+dashboard")
(load! "+bindings")
(load! "+org-modern")
(load! "+modeline")
(load! "+org")
(load! "+deft")
(load! "+company")
;; (load! "book-mode.el")

;; Emacs plus specific
;; (defun my/apply-theme (appearance)
;;   "Load theme, taking current system APPEARANCE into consideration."
;;   (mapc #'disable-theme custom-enabled-themes)
;;   (pcase appearance
;;     ('light (load-theme modus-operandi t))
;;     ('dark (load-theme doom-badger t))))
