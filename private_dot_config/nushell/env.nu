# env.nu
#
# Installed by:
# version = "0.105.1"

$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

$env.STARSHIP_SHELL = "nu"

def create_left_prompt [] {
   starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ": "
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "

$env.EDITOR = "/usr/bin/emacsclient"
$env.VISUAL = "/usr/bin/emacsclient"

# --- Other Toolchains ---
use std "path add"
path add $"($env.HOME)/.local/bin"
path add $"($env.HOME)/local/bin"
path add $"($env.HOME)/.cargo/bin"
path add $"($env.HOME)/.juliaup/bin"
path add $"($env.HOME)/.ghcup/bin"
