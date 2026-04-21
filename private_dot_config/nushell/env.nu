# env.nu
#
# Installed by:
# version = "0.105.1"

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

# --- OCaml / Opam Environment ---

$env.OPAM_SWITCH_PREFIX = "/home/tgaref/.opam/5.4.1"
$env.OCAML_TOPLEVEL_PATH = "/home/tgaref/.opam/5.4.1/lib/toplevel"

# Lists for easier management in Nushell
$env.OCAMLTOP_INCLUDE_PATH = [
    "/home/tgaref/.opam/5.4.1/lib/toplevel"
]

$env.CAML_LD_LIBRARY_PATH = [
    "/home/tgaref/.opam/5.4.1/lib/stublibs"
    "/home/tgaref/.opam/5.4.1/lib/ocaml/stublibs"
    "/home/tgaref/.opam/5.4.1/lib/ocaml"
]

# Update PATH (idempotent addition)
$env.PATH = (
    $env.PATH 
    | split row (char esep)
    | append "/home/tgaref/.opam/5.4.1/bin"
    | uniq
)

# Update MANPATH
if "MANPATH" in $env {
    $env.MANPATH = (
        $env.MANPATH 
        | split row (char esep)
        | append "/home/tgaref/.opam/5.4.1/man"
        | uniq
    )
} else {
    $env.MANPATH = ["/home/tgaref/.opam/5.4.1/man"]
}

# --- Other Toolchains ---
$env.PATH = (
    $env.PATH 
    | append [
        "/home/tgaref/.ghcup/bin"
        "/home/tgaref/.juliaup/bin"
        "/home/tgaref/.cargo/bin"
        "/home/tgaref/local/bin"
        "/home/tgaref/.local/bin"
    ]
    | uniq
)
