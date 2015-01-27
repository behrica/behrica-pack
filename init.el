;; User pack init file
;;
;; Use this file to initiate the pack configuration.
;; See README for more information.

;; Load bindings config
(live-load-config-file "bindings.el")
(live-load-config-file "magit-config.el")
(live-load-config-file "org-config.el")
(live-load-config-file "ess-config.el")




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
      '(nnimap "gmail"
	       (nnimap-address "imap.gmail.com")
	       (nnimap-server-port 993)
	       (nnimap-stream ssl)))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587
				   "carsten.behring@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")


(setq gnus-select-method
      '(nnimap "localhost"
               (nnimap-server-port 1143)
               (nnimap-stream network)))





(require 'git-timemachine)



(server-start)

;;(set-frame-parameter nil 'fullscreen 'fullboth)


(setq browse-url-browser-function 'eww-browse-url) ; use eww as default browser
(setq browse-url-generic-program (executable-find "chromium-browser")
	shr-external-browser 'browse-url-generic)




(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; Customise the location for installed packages
(setq package-user-dir "~/Dropbox/sources/behrica-pack/lib/elpa")

;; Add all packages to the load path
(let ((base "~/Dropbox/sources/behrica-pack/lib/elpa"))
  (add-to-list 'load-path base)
  (dolist (f (directory-files base))
    (let ((name (concat base "/" f)))
      (when (and (file-directory-p name)
                 (not (equal f ".."))
                 (not (equal f ".")))
        (add-to-list 'load-path name)))))

(require 'rich-minority)
(require 'smart-mode-line)

(custom-set-variables
 '(custom-safe-themes
  (quote
   ("e56f1b1c1daec5dbddc50abd00fcd00f6ce4079f4a7f66052cf16d96412a09a9" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" default))))


 (defun copy-line (arg)
    "Copy lines (as many as prefix argument) in the kill ring.
      Ease of use features:
      - Move to start of next line.
      - Appends the copy on sequential calls.
      - Use newline as last char even on the last line of the buffer.
      - If region is active, copy its lines."
    (interactive "p")
    (let ((beg (line-beginning-position))
          (end (line-end-position arg)))
      (when mark-active
        (if (> (point) (mark))
            (setq beg (save-excursion (goto-char (mark)) (line-beginning-position)))
          (setq end (save-excursion (goto-char (mark)) (line-end-position)))))
      (if (eq last-command 'copy-line)
          (kill-append (buffer-substring beg end) (< end beg))
        (kill-ring-save beg end)))
    (kill-append "\n" nil)
    (beginning-of-line (or (and arg (1+ arg)) 2))
    (if (and arg (not (= 1 arg))) (message "%d lines copied" arg)))

 (global-set-key "\C-c\C-k" 'copy-line)
(defun duplicate-current-line (&optional n)
      "duplicate current line, make more than 1 copy given a numeric argument"
      (interactive "p")
      (save-excursion
        (let ((nb (or n 1))
    	  (current-line (thing-at-point 'line)))
          ;; when on last line, insert a newline first
          (when (or (= 1 (forward-line 1)) (eq (point) (point-max)))
    	(insert "\n"))

          ;; now insert as many time as requested
          (while (> n 0)
    	(insert current-line)
    	(decf n)))))

(global-set-key (kbd "C-c C-l") 'duplicate-current-line)

(sml/setup)


(require 'highlight-tail)
(setq highlight-tail-colors '(("black" . 0)
                               ("#bc2525" . 25)
                               ("black" . 100)))
(setq highlight-tail-steps 10
       highlight-tail-timer 0.05)

(highlight-tail-reload)

(dired "~/Dropbox")
