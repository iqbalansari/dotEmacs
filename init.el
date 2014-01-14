;; Save custom variables in separate file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(setq user-full-name "Iqbal Ansari"
      user-mail-address "iqbal.ansari@ignitesol.com")

;; Memory is cheap
(setq gc-cons-threshold 20000000)

;; Use org babel to load rest of the configuration
(require 'org)
(require 'cl)
(org-babel-load-file "~/.emacs.d/iqbal-init.org")
