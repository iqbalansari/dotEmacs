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

;; Disable vc for Git repositories
(delete 'Git vc-handled-backends)

;; Memory is cheap, stop the world only after 100 megabytes are used
(setq gc-cons-threshold (* 100 1024 1024))

;; Use org babel to load rest of the configuration
(require 'org)
(require 'cl-lib)

;; Create .compiled dir in modules
(unless (file-exists-p "~/.emacs.d/modules/.compiled/")
  (make-directory "~/.emacs.d/modules/.compiled/"))

;; Avoid re-extraction if file has not changed
(if (file-newer-than-file-p "~/.emacs.d/iqbal-init.org" 
			    "~/.emacs.d/iqbal-init.el")
    (org-babel-load-file "~/.emacs.d/iqbal-init.org")
  (load-file "~/.emacs.d/iqbal-init.el"))

;; Load private settings if exist
(when (file-exists-p "~/.emacs.d/private.org")
  (org-babel-load-file "~/.emacs.d/private.org"))
