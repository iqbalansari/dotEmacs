(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("0e121ff9bef6937edad8dfcff7d88ac9219b5b4f1570fd1702e546a80dba0832" "d6a00ef5e53adf9b6fe417d2b4404895f26210c52bb8716971be106550cea257" "b5e478c8e066e8f1b21d6db40b1360076249c310e39147abc692e421e0e9fcd0" "936e5cac238333f251a8d76a2ed96c8191b1e755782c99ea1d7b8c215e66d11e" "fc6e906a0e6ead5747ab2e7c5838166f7350b958d82e410257aeeb2820e8a07a")))


(setq user-full-name "Iqbal Ansari"
      user-mail-address "iqbal.ansari@ignitesol.com")

;; Use org babel to load dotFiles

(require 'org)
(require 'cl)
(org-babel-load-file "~/.emacs.d/iqbal-init.org")
