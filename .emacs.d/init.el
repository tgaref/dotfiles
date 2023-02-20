;;; package --- Summary
;;; Commentary:
(require 'package)

;;; Code:
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;(server-start)


(org-babel-load-file (expand-file-name "/home/tgaref/.emacs.d/myinit.org"))

(exec-path-from-shell-initialize)
(setq inhibit-x-resources t)

;(load "~/.emacs.d/myexwm")

(provide 'init)
