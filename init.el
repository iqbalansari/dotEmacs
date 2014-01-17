;; Save custom variables in separate file
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p "~/.emacs.d/custom.el")
  (load custom-file))

;; Memory is cheap, stop the world only after 20 megabytes are used
(setq gc-cons-threshold (* 20 1024 1024))

;; Use org babel to load rest of the configuration
(load "org")
(load "cl-lib")
(org-babel-load-file "~/.emacs.d/iqbal-init.org")

;; Load private settings if exist
(when (file-exists-p "~/.emacs.d/private.org")
  (org-babel-load-file "~/.emacs.d/private.org"))
