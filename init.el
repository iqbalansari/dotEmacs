;; Do not start on windows, if HOME environment is not equal to
;; USERPROFILE. This leads unexpected behaviour such as applications started
;; from emacs do not pick up correct HOME folder
(when (and (equal system-type 'windows-nt)
           (not (string= (expand-file-name (getenv "HOME"))
                         (expand-file-name (getenv "USERPROFILE")))))
  (error "System variables `USERPROFILE' and `HOME' set to different values, 
this may lead to unexpected behaviour, not proceeding. Please set `HOME' to
value of `USERPROFILE', and move your .emacs.d directory there. Remember
to restart any shell you are using to launch emacs after making the changes!"))

;; Use absolute file name of user-emacs-directory.
(setq user-emacs-directory (file-truename "~/.emacs.d/"))

;; Save custom variables in separate file
(setq custom-file (locate-user-emacs-file "custom.el"))

(when (file-exists-p custom-file)
  (load custom-file))

(require 'package)
(setq package-enable-at-startup nil)
(package-initialize 'noactivate)

;; Ensure we have the latest org mode installed
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(unless (package-installed-p 'org-plus-contrib)
  (package-refresh-contents)
  (package-install 'org-plus-contrib))

;; Do not let org overtake shift-arrow, ctrl-arrow keys windmove and buffermove
;; use them. Unfortunately this needs to be set before loading org, hence
;; setting it here
(setq org-replace-disputed-keys t)

(require 'org)

;; Avoid re-extraction if file has not changed
(if (file-newer-than-file-p (locate-user-emacs-file "iqbal-init.org") 
			    (locate-user-emacs-file "iqbal-init.el"))
    (org-babel-load-file (locate-user-emacs-file "iqbal-init.org"))
  (load-file (locate-user-emacs-file "iqbal-init.el")))

;; Load private settings if exist
(when (file-exists-p (locate-user-emacs-file "private.org"))
  (org-babel-load-file (locate-user-emacs-file "private.org")))
