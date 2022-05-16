(defvar tg-nord0 "#2e3440")
(defvar tg-nord1 "#2f343f")
(defvar tg-nord2 "#434c5e")
(defvar tg-nord3 "#4c566a")
(defvar tg-nord4 "#d8dee9")
(defvar tg-nord5 "#e5e9f0")
(defvar tg-nord6 "#eceff4")
(defvar tg-nord7 "#8fbcbb")
(defvar tg-nord8 "#88c0d0")
(defvar tg-nord9 "#81a1c1")
(defvar tg-nord10 "#4CD9FF")
(defvar tg-nord11 "#bf616a")
(defvar tg-nord12 "#d08770")
(defvar tg-nord13 "#ebcb8b")
(defvar tg-nord14 "#41fb93")
(defvar tg-nord15 "#b48ead")

(setq *colors*
      `(,tg-nord1   ;; 0 black
        ,tg-nord11  ;; 1 red
        ,tg-nord14  ;; 2 green
        ,tg-nord13  ;; 3 yellow
        ,tg-nord10  ;; 4 blue
        ,tg-nord14  ;; 5 magenta
        ,tg-nord8   ;; 6 cyan
        ,tg-nord5)) ;; 7 white

(when *initializing*
  (update-color-map (current-screen)))
