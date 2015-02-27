(live-add-pack-lib "ess/lisp")
(load "ess-site")

(define-key ess-mode-map (kbd "C-<return>") 'ess-eval-region-or-line-and-step)


(require 'company-ess)

; Enabling the backend :
; Globally - company ess-backend checks ess mode
(add-to-list 'company-backends 'company-ess-backend)
