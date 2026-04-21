# ~/.config/fish/config.fish

# 1. PATH deduplication (Cleans inherited duplicates before adding new ones)
set -l new_path
for p in $PATH
    if not contains $p $new_path
        set -a new_path $p
    end
end
set -gx PATH $new_path

# 2. Add local bins (idempotent for the session)
fish_add_path --global "$HOME/.local/bin"
fish_add_path --global "$HOME/local/bin"
fish_add_path --global "$HOME/.cargo/bin"
fish_add_path --global "$HOME/.juliaup/bin"
fish_add_path --global "$HOME/.ghcup/bin"
fish_add_path --global "$HOME/.cabal/bin"

# 3. Opam configuration (Guard against double-initialization)
if not contains "$HOME/.opam/5.4.1/bin" $PATH
    source /home/tgaref/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
end

# 4. Standard Fish/Starship setup
starship init fish | source

# 5. Fish-specific shell features
function vterm_printf;
    if begin; [  -n "$TMUX" ]  ; and  string match -q -r "screen|tmux" "$TERM"; end 
        printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
    else if string match -q -- "screen*" "$TERM"
        printf "\eP\e]%s\007\e\\" "$argv"
    else
        printf "\e]%s\e\\" "$argv"
    end
end
