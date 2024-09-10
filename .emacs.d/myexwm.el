;;; package --- summary
;;; Commentary:

;;; Code:

(fringe-mode 1)

;;;; Below are configurations for EXWM.

;; Load EXWM.
(require 'exwm)

;; Fix problems with Ido (if you use it).
;(require 'exwm-config)
;(exwm-config-ido)

;; Set the initial number of workspaces (they can also be created later).
(setq focus-follows-mouse t)
(setq exwm-workspace-number 8)
(setq exwm-layout-show-all-buffers t)
(setq exwm-workspace-show-all-buffers t)

(require 'exwm-systemtray)
(exwm-systemtray-enable)

;; All buffers created in EXWM mode are named "*EXWM*". You may want to
;; change it in `exwm-update-class-hook' and `exwm-update-title-hook', which
;; are run when a new X window class name or title is available.  Here's
;; some advice on this topic:
;; + Always use `exwm-workspace-rename-buffer` to avoid naming conflict.
;; + For applications with multiple windows (e.g. GIMP), the class names of
;    all windows are probably the same.  Using window titles for them makes
;;   more sense.
;; In the following example, we use class names for all windows except for
;; Java applications and GIMP.
(add-hook 'exwm-update-class-hook
      (lambda ()
        (exwm-workspace-rename-buffer exwm-class-name)))

(add-hook 'exwm-update-title-hook
      (lambda ()
        (pcase exwm-class-name
          ("brave" (exwm-workspace-rename-buffer (format "Brave: %s" (truncate-string-to-width exwm-title 45))))
          ("firefox" (exwm-workspace-rename-buffer (format "Firefox: %s" (truncate-string-to-width exwm-title 45)))))))

(defun tg/exwm-move-window-to-workspace(workspace-number)
  (interactive "nMove to workspace: ")
  (let ((frame (exwm-workspace--workspace-from-frame-or-index workspace-number))
        (id (exwm--buffer->id (window-buffer))))
    (exwm-workspace-move-window frame id)))

;(defun tg/setup-window-by-class ()
;  (interactive)
;  (pcase exwm-class-name
;    ("Emacs" (call-interactively #'exwm-input-toggle-keyboard))
;    ("Microsoft Teams - Preview" (exwm-workspace-move-window 0))
;    ("firefox" (exwm-workspace-move-window 1))
;    ("brave" (exwm-workspace-move-window 1))
;    ("mpv" (exwm-floating-toggle-floating))))

;; Manipulate windows as they're created
;(add-hook 'exwm-manage-finish-hook
;          (lambda ()
            ;; Send the window where it belongs
;            (tg/setup-window-by-class)))

;; Hide the modeline on all floating windows
(add-hook 'exwm-floating-setup-hook
          (lambda ()
            (exwm-layout-hide-mode-line)))



(defun tg/exwm-workspace-switch-to-previous ()
  (interactive)
  "Switch to the previous workspace." 
  (let ((index (- exwm-workspace-current-index 1)))
    (unless (< index 0)	
	(exwm-workspace-switch index))))

(defun tg/exwm-workspace-switch-to-next ()
  (interactive)
  "Switch to the next workspace." 
  (let ((index (+ exwm-workspace-current-index 1)))
    (exwm-workspace-switch index)))


;; Global keybindings can be defined with `exwm-input-global-keys'.
;; Here are a few examples:
(setq exwm-input-global-keys
      `(
	(,(kbd "C-M-<right>") . tg/exwm-workspace-switch-to-next)
	(,(kbd "C-M-<left>") . tg/exwm-workspace-switch-to-previous)
	(,(kbd "s-<left>") . windmove-left)          ; move to left window
        (,(kbd "s-<right>") . windmove-right)        ; move to right window
        (,(kbd "s-<up>") . windmove-up)              ; move to upper window
        (,(kbd "s-<down>") . windmove-down)          ; move to lower window
        (,(kbd "S-s-<left>") . shrink-window-horizontally)
        (,(kbd "S-s-<right>") . enlarge-window-horizontally)
        (,(kbd "S-s-<down>") . shrink-window)
        (,(kbd "S-s-<up>") . enlarge-window)
	(,(kbd "C-c p") . battery)
        ;; Bind "s-q" to exit char-mode and fullscreen mode.
        ([?\s-q] . exwm-reset)
        ;; Bind "s-w" to switch workspace interactively.
        ([?\s-w] . exwm-workspace-switch)
        ;; Bind "s-0" to "s-9" to switch to a workspace by its index.
        ,@(mapcar (lambda (i)
                    `(,(kbd (format "s-%d" i)) .
                      (lambda ()
                        (interactive)
                        (exwm-workspace-switch-create ,i))))
                  (number-sequence 0 9))
        ;; Bind "s-&" to launch applications ('M-&' also works if the output
        ;; buffer does not bother you).
        ([?\s-&] . (lambda (command)
		     (interactive (list (read-shell-command "$ ")))
		     (start-process-shell-command command nil command)))
	([f1] . counsel-linux-app)
	;([f1] . (lambda ()
	;	    (interactive)
	;	    (start-process-shell-command "" nil "/usr/bin/rofi -show drun -no-fixed-num-lines -theme launcher")))	
	([?\C-c ?r ?t] . (lambda ()
		     (interactive)
		     (start-process-shell-command "" nil "/usr/bin/alacritty --config-file ~/.config/alacritty/alacritty.yml")))
	([?\s-Q] . (lambda ()
		    (interactive)
		    (start-process "" nil "/home/tgaref/local/bin/rofi-system.fish")))
	([?\C-c ?r ?b] . (lambda ()
			    (interactive)
			    (start-process "" nil "/usr/bin/brave")))))

;; To add a key binding only available in line-mode, simply define it in
;; `exwm-mode-map'.  The following example shortens 'C-c q' to 'C-q'.
(define-key exwm-mode-map [?\C-q] #'exwm-input-send-next-key)

;; The following example demonstrates how to use simulation keys to mimic
;; the behavior of Emacs.  The value of `exwm-input-simulation-keys` is a
;; list of cons cells (SRC . DEST), where SRC is the key sequence you press
;; and DEST is what EXWM actually sends to application.  Note that both SRC
;; and DEST should be key sequences (vector or string).
(setq exwm-input-simulation-keys
      '(
        ;; movement
        ([?\C-b] . [left])
        ([?\M-b] . [C-left])
        ([?\C-f] . [right])
        ([?\M-f] . [C-right])
        ([?\C-p] . [up])
        ([?\C-n] . [down])
        ([?\C-a] . [home])
        ([?\C-e] . [end])
        ([?\M-v] . [prior])
        ([?\C-v] . [next])
        ([?\C-d] . [delete])
        ([?\C-k] . [S-end delete])
        ;; cut/paste.
        ([?\C-w] . [?\C-x])
        ([?\M-w] . [?\C-c])
        ([?\C-y] . [?\C-v])
        ;; search
        ([?\C-s] . [?\C-f])))

;; You can hide the minibuffer and echo area when they're not used, by
;; uncommenting the following line.
;(setq exwm-workspace-minibuffer-position 'bottom)

(desktop-environment-mode)

;; Do not forget to enable EXWM. It will start by itself when things are
;; ready.  You can put it _anywhere_ in your configuration.

(exwm-enable)

(start-process "" nil "/usr/bin/picom")
(start-process-shell-command "" nil "/usr/bin/xset r rate 200 30")
(start-process-shell-command "" nil "/usr/bin/setxkbmap -layout \"us,gr\" -option grp:win_space_toggle -option grp_led:scroll :2")
;;(start-process-shell-command "" nil "/usr/bin/setxkbmap -layout \"us,gr\" -option grp:alt_shift_toggle -option grp_led:scroll :2")
(start-process "" nil "/usr/bin/nm-applet")
;; (start-process "" nil "/usr/bin/megasync")
(start-process "" nil "/usr/bin/dropbox start")
(start-process "" nil "/usr/bin/udiskie")
(start-process "" nil "/usr/bin/xfce4-power-manager")

(provide 'myexwm)

;;; myexwm.el ends here
