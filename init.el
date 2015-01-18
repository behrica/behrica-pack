;; User pack init file
;;
;; Use this file to initiate the pack configuration.
;; See README for more information.

;; Load bindings config
(live-load-config-file "bindings.el")
(live-load-config-file "magit-config.el")
(live-load-config-file "org-config.el")

(live-add-pack-lib "ess/lisp")
(load "ess-site")


(define-key ess-mode-map (kbd "C-<return>") 'ess-eval-region-or-line-and-step)

(setq url-using-proxy t)
(setq url-proxy-services  '(("http" . "127.0.0.1:3128")))

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
    (global-set-key [f11] 'toggle-fullscreen-x11))


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



(setq ispell-silently-savep t)



(autoload 'sunrise-commander "sunrise-commander.el")
(require 'sunrise-commander)





(setq gnus-select-method
      '(nnimap "localhost"
               (nnimap-server-port 1143)
               (nnimap-stream network)
               ))




(server-start)


(dired "~/Dropbox")
