;;; Compiled snippets and support files for `text-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'text-mode
					 '(("email" "`(replace-regexp-in-string \"@\" \"@NOSPAM.\" user-mail-address)`" "(user's email)" nil nil nil nil nil nil)
					   ("time" "`(current-time-string)`" "(current time)" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Mon Sep 23 04:51:18 2013
