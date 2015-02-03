;; User pack init file
;;
;; Use this file to initiate the pack configuration.
;; See README for more information.

;; Load bindings config
(live-load-config-file "bindings.el")
(live-load-config-file "packages-config.el")
(live-load-config-file "magit-config.el")
(live-load-config-file "org-config.el")
(live-load-config-file "ess-config.el")
(live-load-config-file "tex-config.el")
(live-load-config-file "edit-config.el")
(live-load-config-file "gnus-config.el")



(setq url-proxy-services
      '(("no_proxy" . "^\\(localhost\\|10.*\\)")
        ("http" . "127.0.0.1:3128")
        ("https" . "127.0.0.1:3128")))


(autoload 'gfm-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist'("\.text\'" . markdown-mode))
(add-to-list 'auto-mode-alist'("\.markdown\'" . markdown-mode))
(add-to-list 'auto-mode-alist'("\.md\'" . markdown-mode))
(live-add-pack-lib "polymode")
(live-add-pack-lib "polymode/modes")
(live-add-pack-lib "python-mode")




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




(setq ispell-silently-savep t)

(autoload 'sunrise-commander "sunrise-commander.el")
(require 'sunrise-commander)





(require 'git-timemachine)



(server-start)


(setq browse-url-browser-function 'eww-browse-url) ; use eww as default browser
(setq browse-url-generic-program (executable-find "chromium-browser")
      shr-external-browser 'browse-url-generic)






(require 'rich-minority)
(require 'smart-mode-line)

(custom-set-variables
 '(custom-safe-themes
   (quote
    ("e56f1b1c1daec5dbddc50abd00fcd00f6ce4079f4a7f66052cf16d96412a09a9" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" default))))



(sml/setup)


(require 'highlight-tail)
(setq highlight-tail-colors '(("black" . 0)
                              ("#bc2525" . 25)
                              ("black" . 100)))
(setq highlight-tail-steps 10
      highlight-tail-timer 0.05)

(highlight-tail-reload)


(require 'tramp)

(defun find-file-as-root ()
  "Like `ido-find-file, but automatically edit the file with
root-privileges (using tramp/sudo), if the file is not writable by
user."
  (interactive)
  (let ((file (ido-read-file-name "Edit as root: ")))
    (unless (file-writable-p file)
      (setq file (concat "/sudo:root@localhost:" file)))
    (find-file file)))

(global-aggressive-indent-mode 1)


(require 'lispy)
(global-set-key (kbd "C-c d") 'lispy-describe-inline)
(global-set-key (kbd "C-c p") 'lispy-arglist-inline)





(require 'guide-key)
(guide-key-mode 1)


(require 'cider-grimoire)
(require 'cider-inspector)
(require 'cider-selector)
(require 'cider-browse-ns)
(require 'cider-classpath)


(setq guide-key/guide-key-sequence '("C-x" "C-c"))
(setq guide-key/recursive-key-sequence-flag t)




(dired "~/Dropbox")
