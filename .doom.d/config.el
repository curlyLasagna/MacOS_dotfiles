;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq! user-full-name "Luis Dale Gascon"
       user-mail-address "luis.gcodes@gmail.com")

(setq! doom-font (font-spec :family "Roboto Mono" :size 12.5)
       doom-variable-pitch-font (font-spec :family "Lora" :size 14 :height 2.0)
       doom-unicode-font (font-spec :family "Apple Color Emoji" :size 12)
       doom-serif-font (font-spec :family "Input Serif" :size 12)
       line-spacing 0.15)

(setq! undo-limit 80000000)
(setq! frame-title-format '("%b"))
(setq! scroll-preserve-screen-position 'always)
(setq! confirm-kill-emacs nil)

(setq! org-directory "~/Documents/org")
(setq! display-line-numbers-type 'relative)
(setq! truncate-string-ellipsis "…")
(setq! doom-theme 'doom-one-light)
(global-visual-fill-column-mode -1)
(global-visual-line-mode +1)
(global-goto-address-mode +1)
(pixel-scroll-precision-mode +1)
(delete-selection-mode +1)
(global-subword-mode +1)
(column-number-mode +1)

;; Enable horizontal scrolling
(setq! mouse-wheel-tilt-scroll 't)
(setq! mouse-wheel-flip-direction 't)

(when (modulep! :ui modeline +light)
    (setq! +modeline-height 27)
    (setq! size-indication-mode -1))

;; https://emacs.stackexchange.com/questions/55417/change-theme-when-os-dark-mode-changes
(defun user/apply-theme (appearance)
    "Load theme, taking current system appearance into consideration (Light/Dark mode)."
    (mapc #'disable-theme custom-enabled-themes)
    (pcase appearance
        ;; Set light and dark theme
        ('light (load-theme 'doom-one-light  t))
        ('dark (load-theme 'doom-one t)))
    #'doom/reload-theme)

;; MacOS options
(cond (IS-MAC
       ;; Transparent titlebar.
       (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
       (add-to-list 'default-frame-alist '(ns-appearance . dark))
       ;; Prevents some cases of Emacs flickering.
       (add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
       (setq! mac-right-option-modifier 'meta)
       (setq! ns-use-proxy-icon 'nil)
       (setq! ns-pop-up-frames 'fresh)
       (add-hook 'ns-system-appearance-change-functions #'user/apply-theme)))

(setq! doom-fallback-buffer-name "Doom")


(setq! +doom-dashboard-name "😈 Doom")
(setq! +doom-dashboard-banner-dir doom-user-dir)
(setq! fancy-splash-image (concat doom-user-dir "dashBanners/pusheen-drunk.png"))

(add-hook 'Info-selection-hook
          #'info-colors-fontify-node)

(remove-hook! 'doom-first-buffer-hook
    #'global-hl-line-mode)

(add-hook! '+doom-dashboard-mode-hook
    (hl-line-mode -1))


;; Disable Tetris high score buffer when the game is over
;; (defadvice tetris-end-game (around zap-scores activate)
;;   (save-window-excursion ad-do-it))

;; (defun user/asm-mode-hook ()
;;   ;; asm-mode sets it locally to nil, to "stay closer to the old TAB behaviour".
;;   (setq tab-always-indent (default-value 'tab-always-indent)))

;; (add-hook 'asm-mode-hook #'user/asm-mode-hook)
;; (add-hook 'ns-system-appearance-change-functions #'sys/apply-theme)

;; (after! lsp-mode
;;   (setq lsp-enable-symbol-highlighting nijl
;;         ;; Dsiable lsp install suggestion
;;         lsp-enable-suggest-server-download nil))



;; Aesthetically better menu when choosing what citation to insert
;; (setq citar-symbols
;;       `((file ,(all-the-icons-faicon "file-o" :face 'all-the-icons-green :v-adjust -0.1) . " ")
;;         (note ,(all-the-icons-material "speaker_notes" :face 'all-the-icons-blue :v-adjust -0.3) . " ")
;;         (link ,(all-the-icons-octicon "link" :face 'all-the-icons-orange :v-adjust 0.01) . " ")))
;; (setq citar-symbol-separator "  ")

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

;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! dired
    (setf dired-kill-when-opening-new-dired-buffer t))

(after! modus-themes
    (setq! modus-themes-fringes 'nil))

(after! lsp-clangd
    (setq lsp-clients-clangd-args
          '("-j=3"
            "--background-index"
            "--clang-tidy"
            "--completion-style=detailed"
            "--header-insertion=never"
            "--header-insertion-decorators=0"))
    (set-lsp-priority! 'clangd 2))

(after! lsp-mode
    (setq! lsp-ui-sideline-show-diagnostics nil))

(after! which-key
    (setq! which-key-idle-delay 0.5)
    ;; Allow which key to show everything
    ;; https://github.com/doomemacs/doomemacs/issues/6580
    (setq! which-key-allow-imprecise-window-fit nil))

(after! company
    (setq! company-ispell-available nil))

(after! web-mode
    (setq! web-mode-indent-style 4))

(after! org-download
    (setq org-download-method 'directory))

(setq +lookup-open-url-fn #'eww)

(use-package! mixed-pitch
    :config
    (setq mixed-pitch-set-height 't)
    (map!
     :leader
     :desc "Toggle mixed-pitch-mode"
     "t m" #'mixed-pitch-mode))

;; (use-package! lsp-tailwindcss
;;   :init
;;   (setq! lsp-tailwindcss-add-on-mode t))

(use-package! avy
    :config
    (setq! avy-all-windows 't)
    (map!
     :desc "jump to 1 character"
     "C-." #'avy-goto-char
     )

    (map!
     :desc "jump to 2 characters"
     "C-\"" #'avy-goto-char-2
     )

    (map!
     :desc "jump to line"
     "M-g f" #'avy-goto-line
     )

    (map!
     :desc "jump to word at point"
     "M-g w" #'avy-goto-word-0
     ))

(after! yasnippet
    (setq! yas-triggers-in-field 't))

(after! doom-modeline
    (setq! find-file-visit-truename t
           doom-modeline-gnus nil
           doom-modeline-bar-width 3
           doom-modeline-persp-name t
           doom-modeline-buffer-file-name-style 'truncate-upto-root
           all-the-icons-scale-factor 1.1)
    (remove-hook 'doom-modeline-mode-hook #'size-indication-mode))

(after! writeroom-mode
    (setq! writeroom-mode-line nil
           +zen-text-scale 0)
    (add-hook 'writeroom-mode-enable-hook (lambda () (display-line-numbers-mode -1)))
    (add-hook 'writeroom-mode-disable-hook (lambda () (display-line-numbers--turn-on))))


;; ;; Disable adaptive wrap, which indents consequent lines
;; (remove-hook 'visual-line-mode-hook
;;              #'adaptive-wrap-prefix-mode)

;; ;; For good measure
;; (add-hook 'visual-line-mode-hook (lambda () (adaptive-wrap-prefix-mode -1)))

(use-package! org-journal
    :config
    (defun close-other-journal-entries ()
        "Kill org-journal buffers when navigating or creating a new entry."
        (let ((current-buffer (current-buffer)))
            (dolist (buffer (buffer-list))
                (with-current-buffer buffer
                    (when (derived-mode-p 'org-journal-mode)
                        (unless (eq buffer current-buffer)
                            (kill-buffer buffer)))))))

    (add-hook 'org-journal-after-entry-create-hook #'close-other-journal-entries)
    (add-hook 'org-journal-after-entry-view-hook #'close-other-journal-entries)
    (map!
     :desc "Next journal entry"
     :mode org-journal-mode-map
     :leader
     "C-f" #'org-journal-next-entry
     ))

(after! vertico
    (map!
     :map vertico-map
     :desc "Preview file"
     "C-S-SPC" #'+vertico/enter-or-preview))

(use-package! terminal-here
    :config
    (setq! terminal-here-mac-terminal-command 'kitty)
    (map!
     :desc "Open 'terminal-here-mac-terminal-command'"
     :leader
     "o i" #'terminal-here
     ))

(use-package! ace-window
    :config
    (map!
     :desc "ace-window"
     "M-o" #'ace-select-window))

(use-package! heaven-and-hell
    :hook (after-init . heaven-and-hell-init-hook)
    :config
    (setq! heaven-and-hell-load-theme-no-confirm t
           heaven-and-hell-theme-type 'dark
           heaven-and-hell-themes '((light . doom-one-light)
                                    (dark . doom-one)))
    (map!
     :leader
     :desc "Toggle theme"
     "t t" (lambda()
               (interactive)
               (heaven-and-hell-toggle-theme)
               (doom/reload-theme)
               )))

(after! marginalia
    (setq marginalia-censor-variables nil)

    (defadvice! +marginalia--anotate-local-file-colorful (cand)
        "Just a more colourful version of `marginalia--anotate-local-file'."
        :override #'marginalia--annotate-local-file
        (when-let (attrs (file-attributes (substitute-in-file-name
                                           (marginalia--full-candidate cand))
                                          'integer))
            (marginalia--fields
             ((marginalia--file-owner attrs)
              :width 12 :face 'marginalia-file-owner)
             ((marginalia--file-modes attrs))
             ((+marginalia-file-size-colorful (file-attribute-size attrs))
              :width 7)
             ((+marginalia--time-colorful (file-attribute-modification-time attrs))
              :width 12))))

    (defun +marginalia--time-colorful (time)
        (let* ((seconds (float-time (time-subtract (current-time) time)))
               (color (doom-blend
                       (face-attribute 'marginalia-date :foreground nil t)
                       (face-attribute 'marginalia-documentation :foreground nil t)
                       (/ 1.0 (log (+ 3 (/ (+ 1 seconds) 345600.0)))))))
            ;; 1 - log(3 + 1/(days + 1)) % grey
            (propertize (marginalia--time time) 'face (list :foreground color))))

    (defun +marginalia-file-size-colorful (size)
        (let* ((size-index (/ (log10 (+ 1 size)) 7.0))
               (color (if (< size-index 10000000) ; 10m
                              (doom-blend 'orange 'green size-index)
                          (doom-blend 'red 'orange (- size-index 1)))))
            (propertize (file-size-human-readable size) 'face (list :foreground color)))))

(after! projectile
    (setq! projectile-ignored-projects '("~/"
                                         "/tmp"
                                         "~/.emacs.d/"
                                         "~/.emacs.d/.local/straight/repos/"
                                         "/opt/homebrew"))

    (defun projectile-ignored-project-function (filepath)
        "Return t if FILEPATH is within any of `projectile-ignored-projects'"
        (or (mapcar (lambda (p) (s-starts-with-p p filepath)) projectile-ignored-projects))))

(after! treemacs
    (defvar treemacs-file-ignore-extensions '()
        "File extension which `treemacs-ignore-filter' will ensure are ignored")
    (defvar treemacs-file-ignore-globs '()
        "Globs which will are transformed to `treemacs-file-ignore-regexps' which `treemacs-ignore-filter' will ensure are ignored")
    (defvar treemacs-file-ignore-regexps '()
        "RegExps to be tested to ignore files, generated from `treeemacs-file-ignore-globs'")
    (defun treemacs-file-ignore-generate-regexps ()
        "Generate `treemacs-file-ignore-regexps' from `treemacs-file-ignore-globs'"
        (setq treemacs-file-ignore-regexps (mapcar 'dired-glob-regexp treemacs-file-ignore-globs)))
    (if (equal treemacs-file-ignore-globs '()) nil (treemacs-file-ignore-generate-regexps))
    (defun treemacs-ignore-filter (file full-path)
        "Ignore files specified by `treemacs-file-ignore-extensions', and `treemacs-file-ignore-regexps'"
        (or (member (file-name-extension file) treemacs-file-ignore-extensions)
            (let ((ignore-file nil))
                (dolist (regexp treemacs-file-ignore-regexps ignore-file)
                    (setq ignore-file (or ignore-file (if (string-match-p regexp full-path) t nil)))))))
    (add-to-list 'treemacs-ignored-file-predicates #'treemacs-ignore-filter)
    (setq! doom-themes-treemacs-enable-variable-pitch nil
           treemacs-follow-mode t
           treemacs-user-mode-line-format 'none
           treemacs-sorting 'mod-time-asc
           doom-themes-treemacs-theme "doom-atom")

    (setq! treemacs-file-ignore-extensions
           '(;; LaTeX
             "aux"
             "ptc"
             "fdb_latexmk"
             "fls"
             "synctex.gz"
             "toc"
             ;; LaTeX - glossary
             "glg"
             "glo"
             "gls"
             "glsdefs"
             "ist"
             "acn"
             "acr"
             "alg"
             ;; LaTeX - pgfplots
             "mw"
             ;; LaTeX - pdfx
             "pdfa.xmpi"
             ;; Java
             "class"
             ))

    (setq treemacs-file-ignore-globs
          '(;; LaTeX
            "*/_minted-*"
            ;; AucTeX
            "*/.auctex-auto"
            "*/_region_.log"
            "*/_region_.tex"))

    (map!
     :desc "Toggle focus treemacs"
     :leader
     "o p" #'treemacs-select-window))

(map!
 :leader
 :desc "Dashboard"
 "d" #'+doom-dashboard/open)

(map!
 :desc "Next buffer"
 "C-<tab>" #'next-buffer)

(map!
 :desc "Previous buffer"
 "C-S-<tab>" #'previous-buffer)

(when (modulep! :ui workspaces)
    (map!
     :desc "Switch to next workspace"
     "s-}" #'+workspace/switch-right)

    (map!
     :desc "Switch to previous workspace"
     "s-{" #'+workspace/switch-left))

(map!
 :desc "Insert quotes around region"
 "M-\"" #'insert-pair)

(when (file-exists-p custom-file)
    (load custom-file))
