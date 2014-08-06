;; Save custom variables in separate file
(setq custom-file "~/.emacs.d/custom.el")

(when (file-exists-p custom-file)
  (load custom-file))

(require 'package)
(package-initialize)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(unless (package-installed-p 'org-plus-contrib)
  (package-refresh-contents)
  (package-install 'org-plus-contrib))

;; Use org babel to load rest of the configuration
(require 'org)

;; Create .compiled dir in modules
(unless (file-exists-p "~/.emacs.d/modules/.compiled/")
  (make-directory "~/.emacs.d/modules/.compiled/"))

;; Avoid re-extraction if file has not changed
(if (file-newer-than-file-p "~/.emacs.d/my-init.org" 
			    "~/.emacs.d/my-init.el")
    (org-babel-load-file "~/.emacs.d/my-init.org")
  (load-file "~/.emacs.d/my-init.el"))

;; Load private settings if exist
(when (file-exists-p "~/.emacs.d/private.org")
  (org-babel-load-file "~/.emacs.d/private.org"))
