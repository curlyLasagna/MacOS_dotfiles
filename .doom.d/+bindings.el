;;; +bindings.el -*- lexical-binding: t; -*-
;; Open dashboard buffer
(map!
 :leader
 :desc "Dashboard"
 "d" #'+doom-dashboard/open)

(map!
 :leader
 :desc "Toggle light and dark theme"
 :n
 "t t" #'heaven-and-hell-toggle-theme)

(map!
 :leader
 :desc "Toggle mixed-pitch-mode"
 :n
 "t m" #'mixed-pitch-mode)

(map!
 :map org-roam-mode-map
 :leader
 :desc "Open org roam ui"
 "n r u" #'org-roam-ui-open)

(map!
 :map org-journal-mode-map
 :leader
 :desc "Open today's journal file"
 "n j n" #'org-journal-open-current-journal-file)
