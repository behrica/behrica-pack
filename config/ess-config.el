(live-add-pack-lib "ess/lisp")
(load "ess-site")

(define-key ess-mode-map (kbd "C-<return>") 'ess-eval-region-or-line-and-step)
