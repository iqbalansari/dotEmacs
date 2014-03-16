;; Save custom variables in separate file
(require 'package)
(package-initialize)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(unless (package-installed-p 'org-plus-contrib)
  (package-refresh-contents)
  (package-install 'org-plus-contrib))

(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

;; Disable vc for Git repositories
(delete 'Git vc-handled-backends)

;; Memory is cheap, stop the world only after 20 megabytes are used
(setq gc-cons-threshold (* 20 1024 1024))

;; Use org babel to load rest of the configuration
(require 'org)
(require 'cl-lib)
(org-babel-load-file "~/.emacs.d/iqbal-init.org")

;; Load private settings if exist
(when (file-exists-p "~/.emacs.d/private.org")
  (org-babel-load-file "~/.emacs.d/private.org"))
