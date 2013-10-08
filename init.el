(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("936e5cac238333f251a8d76a2ed96c8191b1e755782c99ea1d7b8c215e66d11e" "fc6e906a0e6ead5747ab2e7c5838166f7350b958d82e410257aeeb2820e8a07a" default)))
 '(cursor-type 'bar)
)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:inherit nil :background "black"))))
 '(idle-highlight ((t (:inherit region :background "black"))) t)
 '(linum ((t (:inherit (shadow default) :background "AntiqueWhite4" :foreground "white smoke"))))
 '(mumamo-background-chunk-major ((t (:background "#3F3F3F"))) t)
 '(term-color-blue ((t (:background "nil" :foreground "steel blue"))) t)
 '(term-color-cyan ((t (:background "cyan3" :foreground "medium spring green"))) t)
 '(term-color-magenta ((t (:background "nil" :foreground "hot pink"))) t)
 '(term-color-red ((t (:background "nil" :foreground "dark orange"))) t)
 '(term-color-yellow ((t (:background "nil" :foreground "gold"))) t)
 '(web-mode-html-attr-name-face ((t (:foreground "dark orange"))))
 '(web-mode-html-tag-face ((t (:foreground "lawn green")))))

(setq user-full-name "Iqbal Ansari"
      user-mail-address "iqbal.ansari@ignitesol.com")

;;  '(region ((t (:background "black" :inverse-video nil :underline nil :slant normal :weight normal))))

;; Use org mode to intialize dotFiles

(require 'org)
(org-babel-load-file "~/.emacs.d/iqbal-init.org")
