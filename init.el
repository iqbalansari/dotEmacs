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
 '(ac-candidate-face ((t (:background "white" :foreground "black"))))
 '(ac-selection-face ((t (:inherit popup-menu-selection-face :background "black" :foreground "white"))))
 '(ahs-definition-face ((t (:background "CadetBlue" :foreground "white" :underline nil :slant italic))) t)
 '(ahs-face ((t (:background "SystemMenuText" :foreground "nil" :box nil :slant italic))) t)
 '(android-mode-debug-face ((t (:foreground "red"))) t)
 '(cua-rectangle ((t (:inherit region :background "black"))) t)
 '(cursor ((t (:background "white"))))
 '(diredp-date-time ((t (:foreground "spring green"))) t)
 '(diredp-deletion ((t (:background "nil" :foreground "red1"))) t)
 '(diredp-deletion-file-name ((t (:foreground "red"))) t)
 '(diredp-dir-heading ((t (:background "nil" :foreground "deep sky blue"))) t)
 '(diredp-dir-priv ((t (:background "nil" :foreground "deep sky blue"))) t)
 '(diredp-exec-priv ((t (:background "nil" :foreground "nil"))) t)
 '(diredp-executable-tag ((t (:foreground "chartreuse"))) t)
 '(diredp-file-name ((t (:background "nil" :foreground "chartreuse"))) t)
 '(diredp-file-suffix ((t (:foreground "chartreuse"))) t)
 '(diredp-flag-mark ((t (:background "#787831311414" :foreground "#7575D4D41D1D"))) t)
 '(diredp-no-priv ((t (:background "nil" :foreground "#DCDCCC"))) t)
 '(diredp-number ((t (:foreground "gold"))) t)
 '(diredp-read-priv ((t (:background "nil" :foreground "nil"))) t)
 '(diredp-write-priv ((t (:background "nil" :foreground "nil"))) t)
 '(hl-line ((t (:inherit nil :background "black"))))
 '(idle-highlight ((t (:inherit region :background "black"))) t)
 '(linum ((t (:inherit (shadow default) :background "AntiqueWhite4" :foreground "white smoke"))))
 '(mumamo-background-chunk-major ((t (:background "#3F3F3F"))) t)
 '(show-paren-match ((t (:background "nil" :weight extra-bold))))
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
(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))
