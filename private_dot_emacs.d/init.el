;;; package --- Summary
;;; Commentary:
;(require 'package)

;;; Code:
;(setq package-archives '(("melpa" . "https://melpa.org/packages/")
;                         ("melpa-stable" . "https://stable.melpa.org/packages/")
;                         ("org" . "https://orgmode.org/elpa/")
;                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)

;(server-start)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(setq straight-use-package-by-default t)

(org-babel-load-file (expand-file-name "/home/tgaref/.emacs.d/myinit.org"))

(exec-path-from-shell-initialize)
(setq inhibit-x-resources t)

;;(load "~/.emacs.d/myexwm")

(provide 'init)
