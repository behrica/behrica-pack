(require 'python)

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i")

(defun append-to-buffer-phyton (buffer start end)
  (interactive
   (list (python-shell-get-buffer)
         (region-beginning) (region-end)))
  (let* ((oldbuf (current-buffer))
         (append-to (get-buffer-create buffer))
         (windows (get-buffer-window-list append-to t t))
         point)
    (save-excursion
      (with-current-buffer append-to
        (setq point (point))
        (barf-if-buffer-read-only)
        (insert-buffer-substring oldbuf start end)
        (comint-send-input)
        (dolist (window windows)
          (when (= (window-point window) point)
            (set-window-point window (point))))))))

(define-key python-mode-map (kbd "C-c C-a") 'append-to-buffer-phyton)

(fset 'send-line-to-python
      [?\C-a ?\C-  S-down ?\C-c ?\C-r])

(fset 'append-line-to-python
      [?\C-a ?\C-  S-down ?\C-c ?\C-a])


(define-key python-mode-map (kbd "C-<return>") 'send-line-to-python)
(define-key python-mode-map (kbd "M-<return>") 'append-line-to-python)


(defun lookup-help()
  (interactive)
  (with-output-to-temp-buffer "*Help*"
    (princ (python-shell-send-string-no-output
            (format  "help(%s)"  (python-info-current-symbol))))))

(define-key python-mode-map (kbd "C-c C-d") 'lookup-help)
