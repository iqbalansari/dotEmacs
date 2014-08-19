;; Save custom variables in separate file
(defvar my-home-dir (file-truename "~/.emacs.d/"))
(setq user-emacs-directory my-home-dir)

(setq custom-file (concat my-home-dir "custom.el"))

(when (file-exists-p custom-file)
  (load custom-file))

(require 'package)
(package-initialize)

(dolist (archive '(("org" . "http://orgmode.org/elpa/")
                   ("melpa" . "http://melpa.milkbox.net/packages/")
                   ("marmalade" . "http://marmalade-repo.org/packages/")))
  (add-to-list 'package-archives archive t))

(unless (package-installed-p 'org-plus-contrib)
  (package-refresh-contents)
  (package-install 'org-plus-contrib))

;; Use org babel to load rest of the configuration
(require 'org)

;; Create .compiled dir in modules
(unless (file-exists-p (concat my-home-dir "/modules/.compiled/"))
  (make-directory (concat my-home-dir "/modules/.compiled/")))

;; Avoid re-extraction if file has not changed
(if (file-newer-than-file-p (concat my-home-dir "my-init.org") 
			    (concat my-home-dir "my-init.el"))
    (org-babel-load-file (concat my-home-dir "my-init.org"))
  (load-file (concat my-home-dir "my-init.el")))

;; Load private settings if exist
(when (file-exists-p (concat my-home-dir "private.org"))
  (org-babel-load-file (concat my-home-dir "private.org")))
