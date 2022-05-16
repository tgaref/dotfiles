(when *initializing*
  (grename "1")
  (mapcar  #'gnewbg '("2" "3" "4" "5" "6" "7")))

(clear-window-placement-rules)

(define-frame-preference "1"
  ;; frame raise lock (lock AND raise == jumpto)
  (0 t nil :class "Firefox" :role "...Firefox"))

(setf *dynamic-group-master-split-ratio* 1/2)

