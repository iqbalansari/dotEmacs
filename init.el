(defvar my-home-dir (file-truename "~/.emacs.d/"))
(setq user-emacs-directory my-home-dir)

;; Save custom variables in separate file
(setq custom-file (locate-user-emacs-file "custom.el"))

(when (file-exists-p custom-file)
  (load custom-file))

(require 'package)
(package-initialize)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))

(unless (package-installed-p 'org-plus-contrib)
  (package-refresh-contents)
  (package-install 'org-plus-contrib))

;; Use org babel to load rest of the configuration
(require 'org)

;; Create .compiled dir in modules
(unless (file-exists-p (locate-user-emacs-file "modules/.compiled/"))
  (make-directory (locate-user-emacs-file "modules/.compiled/")))

;; Avoid re-extraction if file has not changed
(if (file-newer-than-file-p (locate-user-emacs-file "my-init.org") 
			    (locate-user-emacs-file "my-init.el"))
    (org-babel-load-file (locate-user-emacs-file "my-init.org"))
  (load-file (locate-user-emacs-file "my-init.el")))

;; Load private settings if exist
(when (file-exists-p (locate-user-emacs-file "private.org"))
  (org-babel-load-file (locate-user-emacs-file "private.org")))
