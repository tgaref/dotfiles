# fish will inherit a clean PATH from ~/.profile during login

# Standard Fish/Starship setup
starship init fish | source

# Only keep necessary fish-specific shell features
function vterm_printf;
    if begin; [  -n "$TMUX" ]  ; and  string match -q -r "screen|tmux" "$TERM"; end 
        printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
    else if string match -q -- "screen*" "$TERM"
        printf "\eP\e]%s\007\e\\" "$argv"
    else
        printf "\e]%s\e\\" "$argv"
    end
end

# Opam initialization for Fish-specific features (completions, hooks)
# It only prepends the OCaml binary if it's not already in the PATH
source /home/tgaref/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
