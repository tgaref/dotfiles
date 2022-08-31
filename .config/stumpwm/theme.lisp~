(load "~/.config/stumpwm/colors.lisp")

(ql:quickload :clx-truetype)
(load-module "ttf-fonts")
(xft:cache-fonts)

(set-font `(,(make-instance 'xft:font :family "Fira Code Medium" :subfamily "Regular" :size 14 :antialias t)
            ,(make-instance 'xft:font :family "FontAwesome" :subfamily "Regular" :size 14 :antialias t)))


(set-border-color        tg-nord1)
(set-focus-color         tg-nord1)
(set-unfocus-color       tg-nord3)
(set-float-focus-color   tg-nord1)
(set-float-unfocus-color tg-nord3)

(set-fg-color tg-nord4)
(set-bg-color tg-nord1)

(setf *normal-border-width*       0
      *float-window-border*       0
      *float-window-title-height* 15
      *window-border-style*       :none
      *window-format*             "%n:%t")

(setf *input-window-gravity*     :top
      *message-window-padding*   10
      *message-window-y-padding* 10
      *message-window-gravity*   :top)

(load-module "swm-gaps")

(setf swm-gaps:*head-gaps-size*  0
      swm-gaps:*inner-gaps-size* 2
      swm-gaps:*outer-gaps-size* 0)

;(when *initializing*
;  (swm-gaps:toggle-gaps))
