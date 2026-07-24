# config.nu
#
# Installed by:
# version = "0.105.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

# oh-my-posh init nu

alias clr = clear
alias rm = rm -i

def l [d? = "."] {
    ls $d | sort-by type
}

def ll [d? = "."] {
    ls -l $d | sort-by type
}


# OCaml / OPAM environment integration
def --env opam-env [] {
    $env.PATH = ($env.PATH | where { |p| not ($p | str contains "/.opam/") })
    let vars = (^opam env --sexp | lines | parse -r '\(\s*"(?<key>[^"]+)"\s+"(?<val>[^"]+)"' | select key val | transpose -r -d)
    let vars = (if "PATH" in $vars { $vars | update PATH {|r| $r.PATH | split row (char esep)} } else { $vars })
    $vars | load-env
    $env.PATH = ($env.PATH | uniq)
}

def --env opam [...args: string] {
    ^opam ...$args
    if ($args | get 0?) == "switch" {
        opam-env
    }
}

opam-env

# Add all ~/.config subdirectories to chezmoi (skipping ~/.config/chezmoi)
def chezmoi-add-config [] {
    ^chezmoi add ...(ls ~/.config | where name !~ "chezmoi" | get name)
}
