;;; js-beautify.el -- beautify some js code
;;; Taken from [http://sethmason.com/2011/04/28/jsbeautify-in-emacs.html]
(defgroup js-beautify nil
  "Use jsbeautify to beautify some js"
  :group 'editing)

(defcustom js-beautify-args "--jslint-happy --brace-style=end-expand"
  "Arguments to pass to jsbeautify script"
  :type '(string)
  :group 'js-beautify)

;;;###autoload
(defun js-beautify ()
  "Beautify a region of javascript using the code from jsbeautify.org"
  (interactive)
  (let ((orig-point (point)))
    (unless (mark)
      (mark-defun))
    (shell-command-on-region (point)
                             (mark)
                             (concat "js-beautify "
                                     " --stdin "
                                     js-beautify-args)
                             nil t)
    (goto-char orig-point)))

(provide 'js-beautify)
;;; js-beautify.el ends here
