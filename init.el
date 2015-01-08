;; User pack init file
;;
;; Use this file to initiate the pack configuration.
;; See README for more information.

;; Load bindings config
(live-load-config-file "bindings.el")

(live-add-pack-lib "ess/lisp")
(setq ess-directory-containing-R "c:/Users/behrica/apps")
(load "ess-site")


(defun my-R-execute-options-w32 ()
     (ess-command "setInternet2(T);library(tcltk);\n"))

(defun my-R-execute-options ()
     (ess-command "library(behricaR);options(max.print = 1000,timeout = 10,menu.graphics = F)\n"))

(when (eq window-system 'w32)
 (add-hook 'ess-R-post-run-hook 'my-R-execute-options-w32))

(add-hook 'ess-R-post-run-hook 'my-R-execute-options)

(define-key ess-mode-map (kbd "C-<return>") 'ess-eval-region-or-line-and-step)



;(require 'poly-R)
;(require 'poly-markdown)

;;; R modes
;(add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
;(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
;(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))


(autoload 'gfm-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist'("\.text\'" . markdown-mode))
(add-to-list 'auto-mode-alist'("\.markdown\'" . markdown-mode))
(add-to-list 'auto-mode-alist'("\.md\'" . markdown-mode))
(live-add-pack-lib "polymode")
(live-add-pack-lib "polymode/modes")


(defun hide-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))


(defun toggle-fullscreen-x11 ()
  "Toggle full screen on X11"
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))


(if (eq window-system 'x)
    (global-set-key [f11] 'toggle-fullscreen-x11)
    (global-set-key [f11] 'toggle-frame-fullscreen))


(defadvice magit-expand-git-file-name
  (before magit-expand-git-file-name-cygwin activate)
  "Handle Cygwin directory names such as /cygdrive/c/*
by changing them to C:/*"
  (when (string-match "^/cygdrive/\\([a-z]\\)/\\(.*\\)" filename)
(setq filename (concat (match-string 1 filename) ":/"
                       (match-string 2 filename)))))

(define-key global-map (kbd "C-c C-SPC") 'er/expand-region)


(cua-mode -1)
(setq cua-rectangle-mark-key (kbd "C-S-<return>"))


(set-face-attribute 'ac-candidate-face nil   :background "#00222c" :foreground "light gray")
(set-face-attribute 'ac-selection-face nil   :background "SteelBlue4" :foreground "white")
(set-face-attribute 'popup-tip-face    nil   :background "#003A4E" :foreground "light gray")

(defun clear-shell ()
   (interactive)
   (let ((old-max comint-buffer-maximum-size))
     (setq comint-buffer-maximum-size 0)
     (comint-truncate-buffer)
     (setq comint-buffer-maximum-size old-max)))


(setq org-agenda-files (quote ("D:/Dropbox/sync/org")))
(global-set-key "\C-ca" 'org-agenda)
(setq org-todo-keywords
      '((sequence "TODO" "STARTED" "WAITING" "|" "DONE" "CANCELLED" )))

(setq ispell-silently-savep t)




(autoload 'sunrise-commander "sunrise-commander.el")
(require 'sunrise-commander)





(dired (or (getenv "DROPBOX_HOME") (getenv "HOME")))
