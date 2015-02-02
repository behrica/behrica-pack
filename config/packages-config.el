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

(package-initialize)
