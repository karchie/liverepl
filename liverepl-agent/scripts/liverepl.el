;; liverepl.el
;; Copyright (c) 2012 Washington University
;; Author: Kevin A. Archie <karchie@wustl.edu>

(defgroup liverepl-bin nil
  "run-lisp wrapper for Clojure liverepl."
  :prefix "liverepl-")

(defcustom liverepl-sh "liverepl.sh"
  "*The name of the liverepl startup script."
  :type 'string
  :group 'liverepl)

(defun join-until-empty (start &rest xs)
  (if (or (string= "" start) (not xs) (string= "" (car xs)))
      start
    (apply 'join-until-empty (concat start " " (car xs)) (cdr xs))))

(defun run-liverepl (&optional pid classloader)
  "Run liverepl as an inferior lisp. pid is the system process ID
for the target JVM. classloader is the classloader index."
  (interactive
   (let* ((pid (read-string "Target JVM pid: "))
	  (classloader (if (string= "" pid)
			   ""
			 (read-string "Classloader index: "))))
     (list pid classloader)))
  (run-lisp (join-until-empty "/bin/sh" liverepl-sh pid classloader)))
