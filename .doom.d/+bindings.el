;;; +bindings.el -*- lexical-binding: t; -*-
;; Open dashboard buffer
(map! :leader :desc "Dashboard" "d" #'+doom-dashboard/open)
(map! :leader :desc "Hide comments" :n "c /" #'obvious-mode)
(map! :desc "Activate emmet" :n "C-S-E" 'emmet-expand-line :when web-mode-hook)
