;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq! user-full-name "Luis Dale Gascon"
       user-mail-address "luis.gcodes@gmail.com")

(setq! doom-font (font-spec :family "Fira Code" :size 12 :weight 'light)
       doom-variable-pitch-font (font-spec :family "ETBembo" :size 16 :height 2.0)
       doom-unicode-font (font-spec :family "Hack Nerd Font" :size 12)
       doom-serif-font (font-spec :family "Input Serif" :size 12))

;; Frame
(setq! frame-title-format '("Emacs | %b"))
(setq! ns-use-proxy-icon nil)
;; Emoji appearance
(setq! emojify-emoji-set "twemoji-v2")
(setq! display-line-numbers-type 'relative)
(setq! truncate-string-ellipsis "…")
;; Trigger snippets inside snippets
(setq! yas-triggers-in-field t)
(setq! doom-fallback-buffer-name "► Doom")
(setq! +doom-dashboard-name "► Doom")
(setq doom-scratch-initial-major-mode 'emacs-lisp-mode)
(setf dired-kill-when-opening-new-dired-buffer t)
(setq-default fill-column 90)
;; Allow which key to show everything
;; https://github.com/doomemacs/doomemacs/issues/6580
(setq which-key-allow-imprecise-window-fit nil)
;; Disables spell in check in latex for performance
(setq-hook! 'LaTex-mode-hook +spellcheck-immediately nil)

(after! evil
  (setq evil-move-cursor-back nil
        evil-kill-on-visual-paste nil))

;; MacOS specific options
(cond (IS-MAC
       ;; Transparent titlebar.
       (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
       (add-to-list 'default-frame-alist '(ns-appearance . dark))
       (setq mac-right-option-modifier 'meta)))

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
   heaven-and-hell-themes '((light . doom-earl-grey)
                            (dark . doom-tokyo-night))))
;; https://emacs.stackexchange.com/questions/55417/change-theme-when-os-dark-mode-changes
(defun sys/apply-theme (appearance)
  "Load theme, taking current system APPEARANCE into consideration."
  (mapc #'disable-theme custom-enabled-themes)
  (pcase appearance
    ;; Set light and dark theme
    ('light (load-theme 'doom-earl-grey t))
    ('dark (load-theme 'doom-tokyo-night t)))
  #'doom/reload-theme)

(add-hook 'ns-system-appearance-change-functions #'sys/apply-theme)

(after! lsp-mode
  (setq lsp-enable-symbol-highlighting nil
        ;; Dsiable lsp install suggestion
        lsp-enable-suggest-server-download nil))

(after! mixed-pitch
  (setq mixed-pitch-set-height t))

(after! tex
  (setq +latex-viewers '(pdf-tools skim)))

(setq org-latex-create-formula-image-program 'dvisvgm)
(after! org
  (plist-put org-format-latex-options :scale 2.0))
;; NeoTree config
;; - Set consistent font
;; - Use icons
;; (after! neotree
;;   (setq doom-themes-neotree-enable-variable-pitch nil
;;         doom-themes-neotree-line-spacing 1
;;         doom-themes-neotreefile-icons t))

(use-package! treemacs
  :config
  (setq doom-themes-treemacs-enable-variable-pitch nil
        treemacs-follow-mode t
        ;;
        treemacs-sorting 'mod-time-asc
        ;; Use dired icons as icons
        doom-themes-treemacs-theme "doom-colors"))

(after! lsp-clangd
  (setq lsp-clients-clangd-args
        '("-j=3"
          "--background-index"
          "--clang-tidy"
          "--completion-style=detailed"
          "--header-insertion=never"
          "--header-insertion-decorators=0"))
  (set-lsp-priority! 'clangd 2))


;; Disable spelling suggestions for better performance
(after! text-mode
  (set-company-backend! 'company-ispell nil))

;; Aesthetically better menu when choosing what citation to insert
(setq citar-symbols
      `((file ,(all-the-icons-faicon "file-o" :face 'all-the-icons-green :v-adjust -0.1) . " ")
        (note ,(all-the-icons-material "speaker_notes" :face 'all-the-icons-blue :v-adjust -0.3) . " ")
        (link ,(all-the-icons-octicon "link" :face 'all-the-icons-orange :v-adjust 0.01) . " ")))
(setq citar-symbol-separator "  ")

;; https://hieuphay.com/doom-emacs-config/
(use-package! yasnippet
  :config
  ;; It will test whether it can expand, if yes, change cursor color
  (defun hp/change-cursor-color-if-yasnippet-can-fire (&optional field)
    (interactive)
    (setq yas--condition-cache-timestamp (current-time))
    (let (templates-and-pos)
      (unless (and yas-expand-only-for-last-commands
                   (not (member last-command yas-expand-only-for-last-commands)))
        (setq templates-and-pos (if field
                                    (save-restriction
                                      (narrow-to-region (yas--field-start field)
                                                        (yas--field-end field))
                                      (yas--templates-for-key-at-point))
                                  (yas--templates-for-key-at-point))))
      (set-cursor-color (if (and templates-and-pos (first templates-and-pos)
                                 (eq evil-state 'insert))
                            (doom-color 'red)
                          (face-attribute 'default :foreground)))))
  :hook (post-command . hp/change-cursor-color-if-yasnippet-can-fire))

;; https://gist.github.com/mads-hartmann/3402786?permalink_comment_id=4263171#gistcomment-4263171
;; Maximize buffer with a toggle
;; Works nicely with neotree but doesn't hide treemacs at the moment
(defun user/toggle-maximize-buffer ()
  "Maximize buffer."
  (interactive)
  (save-excursion
    (if (and (= 1 (length (cl-remove-if
                           (lambda (w)
                             (or (and (fboundp 'treemacs-is-treemacs-window?)
                                      (treemacs-is-treemacs-window? w))
                                 (and (bound-and-true-p neo-global--window)
                                      (eq neo-global--window w))))
                           (window-list))))
             (assoc ?_ register-alist))
        (jump-to-register ?_)
      (window-configuration-to-register ?_)
      (delete-other-windows))))

;; https://stackoverflow.com/questions/384284/how-do-i-rename-an-open-file-in-emacs
;; Originally from stevey, adapted to support moving to a new directory.
(defun user/rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive
   (progn
     (if (not (buffer-file-name))
         (error "Buffer '%s' is not visiting a file!" (buffer-name)))
     ;; Disable ido auto merge since it too frequently jumps back to the original
     ;; file name if you pause while typing. Reenable with C-z C-z in the prompt.
     (let ((ido-auto-merge-work-directories-length -1))
       (list (read-file-name (format "Rename %s to: " (file-name-nondirectory
                                                       (buffer-file-name))))))))
  (if (equal new-name "")
      (error "Aborted rename"))
  (setq new-name (if (file-directory-p new-name)
                     (expand-file-name (file-name-nondirectory
                                        (buffer-file-name))
                                       new-name)
                   (expand-file-name new-name)))
  ;; Only rename if the file was saved before. Update the
  ;; buffer name and visited file in all cases.
  (if (file-exists-p (buffer-file-name))
      (rename-file (buffer-file-name) new-name 1))
  (let ((was-modified (buffer-modified-p)))
    ;; This also renames the buffer, and works with uniquify
    (set-visited-file-name new-name)
    (if was-modified
        (save-buffer)
      ;; Clear buffer-modified flag caused by set-visited-file-name
      (set-buffer-modified-p nil)))

  (setq default-directory (file-name-directory new-name))

  (message "Renamed to %s." new-name))

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
        lsp-lens-enable t ;; not working properly with ccls!
        lsp-diagnostics-provider :auto
        lsp-enable-symbol-highlighting t
        lsp-headerline-breadcrumb-enable nil
        ))

(add-hook 'after-change-major-mode-hook
          #'doom-modeline-conditional-buffer-encoding)

;; Startup hook
(add-hook! 'after-init-hook
          'heaven-and-hell-init-hook
          'global-goto-address-mode
          'pixel-scroll-precision-mode
          'delete-selection-mode)

;; Pretty info
(add-hook 'Info-selection-hook
          #'info-colors-fontify-node)

(add-hook! '(prog-mode-hook)
           #'+word-wrap-mode
           #'display-line-numbers-mode)

(remove-hook! '(org-mode-hook doom-docs-mode-hook)
           #'display-line-numbers)

(load! "+which-key")
(load! "+projectile")
(load! "+dashboard")
(load! "+bindings")
(load! "+org-modern")
(load! "+modeline")
(load! "+company")
