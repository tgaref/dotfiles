# ~/.config/fish/config.fish

# 1. Deduplicate inherited PATH
set -l new_path
for p in $PATH
    if not contains $p $new_path
        set -a new_path $p
    end
end
set -gx PATH $new_path

# 2. Add local binaries (fish_add_path is idempotent)
fish_add_path --global "$HOME/.local/bin"
fish_add_path --global "$HOME/local/bin"
fish_add_path --global "$HOME/.cargo/bin"
fish_add_path --global "$HOME/.juliaup/bin"
fish_add_path --global "$HOME/.ghcup/bin"
fish_add_path --global "$HOME/.cabal/bin"

# 3. Opam environment
if command -q opam; and test -f "$HOME/.opam/opam-init/init.fish"
    source "$HOME/.opam/opam-init/init.fish" > /dev/null 2> /dev/null; or true
end

# 4. Prompt / Starship
starship init fish | source

# 5. Fish-specific helper functions
function vterm_printf;
    if begin; [ -n "$TMUX" ]; and string match -q -r "screen|tmux" "$TERM"; end 
        printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
    else if string match -q -- "screen*" "$TERM"
        printf "\eP\e]%s\007\e\\" "$argv"
    else
        printf "\e]%s\e\\" "$argv"
    end
end

function dotsave --description "Sync and push dotfiles with chezmoi"
    set -l msg "Update configs"
    if test (count $argv) -gt 0
        set msg "$argv"
    end
    chezmoi re-add
    and chezmoi git -- add -A
    if not chezmoi git -- diff --cached --quiet
        chezmoi git -- commit -m "$msg"
        and chezmoi git -- push
    else
        echo "No changes to commit."
    end
end
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /var/home/tgaref/miniconda3/bin/conda
    eval /var/home/tgaref/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/var/home/tgaref/miniconda3/etc/fish/conf.d/conda.fish"
        . "/var/home/tgaref/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/var/home/tgaref/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

