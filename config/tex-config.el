(setq TeX-auto-save t)
(setq TeX-parse-self t)

(setq TeX-command-force "")


(defun build-view ()
  (interactive)
  (if (buffer-modified-p)
      (progn
        (let ((TeX-save-query nil))
          (TeX-save-document (TeX-master-file)))
        (setq build-proc (TeX-command "LaTeX" 'TeX-master-file -1))
        (set-process-sentinel  build-proc  'build-sentinel))
    (TeX-view)))

(defun build-sentinel (process event)
  (if (string= event "finished\n")
      (TeX-view)
    (message "Errors! Check with C-`")))

(add-hook 'LaTeX-mode-hook '(lambda () (local-set-key (kbd "<f9>") 'build-view)))
