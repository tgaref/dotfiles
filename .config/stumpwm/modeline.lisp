;;; Swank settings                                                          ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(require :swank);
;(swank-loader:init)

;(defparameter *port-number* 4004
;  "My default port number for Swank")

;(defvar *swank-server-p* nil
;  "Keep track of swank server, turned off by default on startup")

;(defcommand start-swank () ()
;  "Start Swank if it is not already running"
;  (if *swank-server-p*
;      (message "Swank server is already active on Port^5 ~a^n" *port-number*)
;      (progn
;	(swank:create-server :port *port-number*
;			     :style swank:*communication-style*
;			     :dont-close t)
;	(setf *swank-server-p* t)
;	(message "Swank server is now active on Port^5 ~a^n.
;Use^4 M-x slime-connect^n in Emacs. 
;Type^2 (in-package :stumpwm)^n in Slime REPL." *port-number*))))

;(defcommand stop-swank () ()
;  "Stop Swank"
;  (swank:stop-server *port-number*)
;  (setf *swank-server-p* nil)
;  (message "Stopping Swank Server! Closing Port^5 ~a^n." *port-number*))

;(defcommand toggle-swank () ()
;  (if *swank-server-p*
;      (run-commands "stop-swank")
;      (run-commands "start-swank")))

;(define-key *top-map* (kbd "s-s") "toggle-swank")

;; modeline status
;(defun get-swank-status ()
;  (if *swank-server-p*
;      (setf *swank-ml-status* (format nil "Swank ^3^f1^f0^n Port:^5 ~a^n " *port-number*))
;      (setf *swank-ml-status* "")))

;(defun ml-fmt-swank-status (ml)
;  (declare (ignore ml))
;  (get-swank-status))

;(add-screen-mode-line-formatter #\S #'ml-fmt-swank-status)
;(setf *mode-line-timeout* 2)

;;; end of swank settings

(require :slynk)

(defparameter *port-number* 4005
  "My default port number for Slynk")

(defvar *slynk-server-p* nil
  "Keep track of slynk server, turned off by default on startup")

(defcommand start-slynk () ()
  (if *slynk-server-p*
      (message "Slynk server is already active on Port^5 ~a^n.")
      (progn
	(sb-thread:make-thread
	 (lambda ()
	   (slynk:create-server :port *port-number*
				:dont-close t))
	 :name "slynk-manual")
	(setf *slynk-server-p* t)
	(message "Slynk server is now active on Port^5 ~a^n.
Use^6 M-x sly-connect^n in Emacs. 
Type^6 (in-package :stumpwm)^n in Slime REPL." *port-number*))))

(defcommand stop-slynk () ()
  "Stop Slynk"
  (slynk:stop-server *port-number*)
  (setf *slynk-server-p* nil)
  (message "Stopping Slynk Server! Closing Port^5 ~a^n." *port-number*))

(defcommand toggle-slynk () ()
  (if *slynk-server-p*
      (run-commands "stop-slynk")
      (run-commands "start-slynk")))

(define-key *top-map* (kbd "s-s") "toggle-slynk")

;; modeline status
(defun get-slynk-status ()
  (if *slynk-server-p*
      (setf *slynk-ml-status* (format nil "Slynk ^5^f1^f0^n Port:^3 ~a^n " *port-number*))
      (setf *slynk-ml-status* "")))

(defun ml-fmt-slynk-status (ml)
  (declare (ignore ml))
  (get-slynk-status))

(add-screen-mode-line-formatter #\S #'ml-fmt-slynk-status)
(setf *mode-line-timeout* 2)

;;;

 	

;(setf *colors* (append *colors*
;                       (list "#81efba")))
;(update-color-map (current-screen))

(setf *time-modeline-string* "^2 %d-%m-%Y %H:%M^n")

(setf *group-format* "%t")

(setf *window-format* "%n: %30t")

(load "~/.config/stumpwm/colors.lisp")

(setf *mode-line-background-color* tg-nord1
      *mode-line-foreground-color* tg-nord5)


(setf *mode-line-border-color* tg-nord1
      *mode-line-border-width* 0)

(defparameter *battery-percent* "")

(defun get-battery-status ()
  (let* ((batgetcap (run-shell-command "cat /sys/class/power_supply/BAT0/capacity | tr -d '\\r\\n'" t)))
    (setf *battery-percent* (format nil "^f1^f0 ~a% " batgetcap))))

(defun battery-percentage (ml)
  (declare (ignore ml))
  *battery-percent*)
  
(run-with-timer 0 10 #'get-battery-status)
(add-screen-mode-line-formatter #\B #'battery-percentage)

(defun get-volume ()
  (string-trim
   (string #\newline)
   (format nil "^f1^f0 ~a" (run-shell-command "amixer sget Master | awk '/^ +Front L/{print substr($5,2,length($5)-2)}'" t))))

(load-module :mem)
(load-module :cpu)

(setf *screen-mode-line-format*
      (list "^3 %g ^n "       ; groups
	    "%W"              ; windows
	    "^>"              ; right align
	    "%S  "              ; slynk status
	    "^f1^f0%C "
	    "^f1^f0%M " ; memory
	    "%B "              ; battery percentage
	    '(:eval (get-volume)) ""
            " %d"
	    " %T"))            ; time/date

;; turn on the mode line
(if (not (head-mode-line (current-head)))
    (toggle-mode-line (current-screen) (current-head)))
