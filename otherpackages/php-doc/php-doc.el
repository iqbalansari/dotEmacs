;;; php-doc.el --- doc block generator/extractor for php

;; Copyright (C) 2010, 2013 Stefan Siegl <stesie@brokenpipe.de>

;; Maintainer: Stefan Siegl <stesie@brokenpipe.de>
;; Author: Stefan Siegl <stesie@brokenpipe.de>
;; Keywords: php docblock
;; Created: 2010
;; Modified: 2013-09-14
;; X-URL: https://gist.github.com/stesie

;;; License

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
;; 02111-1307, USA.

;;; Usage

;; Put this file in your Emacs lisp path (eg. site-lisp) and add to
;; your .emacs file:
;;
;;   (require 'php-doc)

;; Then bind it to whatever key you like
;;
;; (add-hook 'php-mode-hook
;;           (lambda ()
;;             (local-set-key (kbd "M-P") 'php-insert-doc-block)))


;;; Code:

(defgroup php-doc nil
  "PHP docblock generator"
  :prefix "php-insert-doc-"
  :group 'php)

(defcustom php-insert-doc-access-tag t
  "When set to true a @access tag is added to generated docblocks."
  :type 'boolean
  :group 'php-doc)

(defcustom php-insert-doc-attribute-tags t
  "When set to true tags like @abstract or @static are added to
generated docblocks."
  :type 'boolean
  :group 'php-doc)

(defcustom php-insert-doc-uses-tag t
  "When set to true a @uses tag is added for inheritting classes."
  :type 'boolean
  :group 'php-doc)

(defcustom php-insert-doc-varname-on-var t
  "When set to true the variable name is repeated in the doc block,
otherwise only ``@var mixed'' is written."
  :type 'boolean
  :group 'php-doc)

(defcustom php-insert-doc-package-tag nil
  "When set to NIL no @package tag is written to class doc blocks.
Otherwise the provided string is used."
  :type 'string
  :group 'php-doc)

(defcustom php-insert-doc-global-type-alist nil
  "Alist mapping global variable names to doc block types.
If this alist has no key equal to the variable name, the @global tag
is written with type set to ``mixed''."
  :type '(alist :key-type string :value-type string)
  :group 'php-doc)

(defcustom php-insert-doc-author-name (user-full-name)
  "The name to use for the @author tag.
If set to NIL no @author tag is written at all."
  :type 'string
  :group 'php-doc)

(defcustom php-insert-doc-author-email user-mail-address
  "The email address to use for the @author tag.
If set to NIL no email address is written next to the @author tag."
  :type 'string
  :group 'php-doc)

(defcustom php-insert-doc-copyright-name (user-full-name)
  "The name to use for the @copyright tag.
If set to NIL no @copyright tag is written at all."
  :type 'string
  :group 'php-doc)

(defcustom php-insert-doc-copyright-email user-mail-address
  "The email address to use for the @copyright tag.
If set to NIL no email address is written next to the @copyright tag."
  :type 'string
  :group 'php-doc)


(defun php-insert-doc-block ()
  "Insert php-doc block for current function, class or variable."
  (interactive)
  (let ((end (point)))
    (when (looking-at "\\s\)")
      (backward-list 1))
    (back-to-indentation)

    (let ((start (point)))
      (php-insert-doc-block-for-string
       (buffer-substring-no-properties (point) end))
      (indent-region start (point) nil)
      (indent-according-to-mode)

      ;; last but not least position point at first line of doc block
      (goto-char start)
      (next-line)
      (end-of-line))))


(defun php-insert-doc-block-for-function (attributes arglist)
  "Insert php-doc block for the specified function"
  (dolist (arg (split-string arglist "\s*,\s*"))
    (php-insert-doc-block-param "param" arg t))

  (php-insert-doc-block-tags-for-attributes attributes)
  (php-insert-doc-block-access-tag attributes)

  (let ((content)
        (start 0))
    (save-excursion
      (set-mark (point))
      (php-end-of-defun)
      (setq content (buffer-substring-no-properties (mark) (point))))

    (while (string-match "global \\(\\(\s*,?\s*$[a-zA-Z0-9_]+\\)+\\)\s*;" content start)
      (setq start (match-end 0))
      (dolist (var-name (split-string (match-string 1 content) "\s*,\s*"))
        (insert "* @global ")
        (insert (or
                 (cdr (assoc-string var-name php-insert-doc-global-type-alist))
                 "mixed"))
        (insert " ")
        (insert var-name)
        (insert "\n")))

    (when (string-match "return" content)
      (insert "* @return mixed\n"))))

(defun php-insert-doc-block-tags-for-attributes (attributes)
  (when php-insert-doc-attribute-tags
    (when (string-match "static" attributes) (insert "* @static\n"))
    (when (string-match "final" attributes) (insert "* @final\n"))
    (when (string-match "abstract" attributes) (insert "* @abstract\n"))))

(defun php-insert-doc-block-access-tag (attributes)
  (let ((access "public"))
    (when (string-match "private" attributes) (setq access "private"))
    (when (string-match "protected" attributes) (setq access "protected"))

    (when php-insert-doc-access-tag
      (insert "* @access " access "\n"))))

(defun php-insert-doc-block-for-class (sig)
  (when php-insert-doc-package-tag
    (insert-string "* @package ")
    (insert-string php-insert-doc-package-tag)
    (insert-string "\n"))

  (when php-insert-doc-uses-tag
    (when (string-match "extends\s+\\(\[A-Za-z0-9_\]+\\)" sig)
      (insert (concat "* @uses " (match-string 1 sig) "\n"))))

  (when php-insert-doc-copyright-name
    (insert "* @copyright ")
    (insert (format-time-string "%Y"))
    (insert " ")
    (insert php-insert-doc-copyright-name)
    (when php-insert-doc-copyright-email
      (insert " <")
      (insert php-insert-doc-copyright-email)
      (insert ">"))
    (insert "\n"))

  (when php-insert-doc-author-name
    (insert "* @author ")
    (insert php-insert-doc-author-name)
    (when php-insert-doc-author-email
      (insert " <")
      (insert php-insert-doc-author-email)
      (insert ">"))
    (insert "\n")))


(defun php-insert-doc-block-for-string (sig)
  "Insert php-doc block for provided function, class or variable signature"
  (catch 'handled
    (insert "/**\n* \n*\n")

    ;; handle functions
    (when (string-match "function\s*\\([A-Za-z0-9_]+\\)\s*\(\\([^\)]*\\)\)" sig)
      (php-insert-doc-block-for-function (substring sig 0 (match-beginning 0))
                                         (match-string 2 sig))
      (throw 'handled t))

    ;; handle classes
    (when (string-match "class" sig)
      (php-insert-doc-block-for-class sig)
      (throw 'handled t))

    ;; (try to) handle everything else (i.e. variables)
    (php-insert-doc-block-param "var" sig php-insert-doc-varname-on-var)
    (php-insert-doc-block-tags-for-attributes sig)
    (php-insert-doc-block-access-tag sig))

  (insert "*/\n"))

(defun php-insert-doc-block-param (type arg insert-param-name)
  (when (string-match "\s*\\([a-zA-Z0-9_]+\\)?\s*\\($\[a-zA-Z0-9_\]+\\)\s*\\(=\[^;\]*\\)?" arg)
    (let ((param-type "mixed")
          (param-name (match-string 2 arg)))

      ;; consider type hint
      (when (match-beginning 1)
        (setq param-type (match-string 1 arg))

        ;; make sure not to match a keyword
        (dolist (keyword '("final" "abstract" "static" "public" "private" "protected" "var"))
          (when (string= keyword param-type)
            (setq param-type "mixed"))))

      ;; check initializer
      (when (and (string= param-type "mixed") (match-beginning 3))
        (setq arg (match-string 3 arg))

        (when (string-match "^=\s*\['\"]" arg)
          (setq param-type "string"))
        (when (string-match "^=\s*\[0-9\]+$" arg)
          (setq param-type "int"))
        (when (string-match "^=\s*\[0-9\]*\\.\[0-9\]+$" arg)
          (setq param-type "float"))
        (when (string-match "^=\s*true$" arg)
          (setq param-type "bool"))
        (when (string-match "^=\s*false$" arg)
          (setq param-type "bool")))

      (insert (concat "* @" type " " param-type))

      (when insert-param-name
        (insert " ")
        (insert param-name))

      (insert "\n"))))


(provide 'php-doc)

