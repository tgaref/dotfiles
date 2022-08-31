(defcommand firefox () ()
            "Run or raise Firefox."
            (run-or-raise "firefox" '(:class "Firefox") t nil))

(defcommand delete-window-and-frame () ()
            "Delete the current frame with its window."
            (delete-window)
            (remove-split))

(defcommand hsplit-and-focus () ()
            "Create a new frame on the right and focus it."
            (hsplit)
            (move-focus :right))

(defcommand vsplit-and-focus () ()
            "Create a new frame below and move focus to it."
            (vsplit)
            (move-focus :down))

(load-module "scratchpad")

(defcommand scratch-term () ()
  (scratchpad:toggle-floating-scratchpad "term" "alacritty --config-file /home/tgaref/.config/alacritty/alacritty.yml --class term -e tmux"
                                         :initial-gravity :center
                                         :initial-width 1400
                                         :initial-height 800))

(defcommand scratch-emacs () ()
  (scratchpad:toggle-floating-scratchpad "scratch-emacs" "emacsclient -c"
                                         :initial-gravity :center
                                         :initial-width 1400
                                         :initial-height 800))
