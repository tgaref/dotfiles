# ~/.config/fish/config.fish

# 1. PATH initialization (idempotent)
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/local/bin"
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.juliaup/bin"
fish_add_path "$HOME/.ghcup/bin"
fish_add_path "$HOME/.cabal/bin"
fish_add_path "$HOME/.pyenv/bin"

# 2. Opam configuration
# Sourced only if the bin dir is not already in PATH to avoid duplicates
if not contains "$HOME/.opam/5.4.1/bin" $PATH
    source /home/tgaref/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
end

# 3. Standard Fish/Starship setup
starship init fish | source

# 4. Fish-specific shell features
function vterm_printf;
    if begin; [  -n "$TMUX" ]  ; and  string match -q -r "screen|tmux" "$TERM"; end 
        printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
    else if string match -q -- "screen*" "$TERM"
        printf "\eP\e]%s\007\e\\" "$argv"
    else
        printf "\e]%s\e\\" "$argv"
    end
end
