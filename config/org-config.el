(setq org-agenda-files (quote ("~/Dropbox/sync/org")))
(global-set-key "\C-ca" 'org-agenda)
(setq org-todo-keywords
      '((sequence "TODO" "STARTED" "WAITING" "|" "DONE" "CANCELLED" )))

(setq org-directory "~/Dropbox/sync/org")
(setq org-mobile-directory "~/Dropbox/MobileOrg")
(setq org-mobile-files '("~/Dropbox/sync/org"))
(setq org-mobile-inbox-for-pull "~/Dropbox/sync/org/inbox.org")

;; moble sync
(defvar org-mobile-sync-timer nil)
(defvar org-mobile-sync-idle-secs (* 60 10))
                                        ;(defvar org-mobile-sync-idle-secs 1)
(defun org-mobile-sync ()
  (interactive)
  (org-mobile-pull)
  (org-mobile-push))
(defun org-mobile-sync-enable ()
  "enable mobile org idle sync"
  (interactive)
  (setq org-mobile-sync-timer
        (run-with-idle-timer org-mobile-sync-idle-secs t
                             'org-mobile-sync)));
(defun org-mobile-sync-disable ()
  "disable mobile org idle sync"
  (interactive)
  (cancel-timer org-mobile-sync-timer))
(org-mobile-sync-enable)

(set-variable 'org-export-allow-bind-keywords t)


(org-add-link-type "thunderlink" 'org-thunderlink-open)

(defun org-thunderlink-open (path)
  (let ( (command (concat  "thunderbird -thunderlink " "thunderlink:" path)))
    (message command)
    (shell-command command)))

(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
      '(("t" "Simple todo" entry (file+headline (concat org-directory "/notes.org") "Tasks")
         "* TODO %?\n")))
