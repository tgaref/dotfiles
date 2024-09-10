# ghcup-env
test -f /home/tgaref/.ghcup/env;

starship init fish | source

function vterm_printf;
    if begin; [  -n "$TMUX" ]  ; and  string match -q -r "screen|tmux" "$TERM"; end 
        # tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
    else if string match -q -- "screen*" "$TERM"
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$argv"
    else
        printf "\e]%s\e\\" "$argv"
    end
end

#if status is-interactive
#    eval (zellij setup --generate-auto-start fish | string collect)
#end

# set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/tgaref/.ghcup/bin $PATH # ghcup-env

# opam configuration
source /home/tgaref/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/tgaref/anaconda3/bin/conda
    eval /home/tgaref/anaconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/tgaref/anaconda3/etc/fish/conf.d/conda.fish"
        . "/home/tgaref/anaconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/tgaref/anaconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

