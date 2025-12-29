# env.nu
# Nushell Environment Configuration

# --- Path Configuration ---
$env.PATH = ($env.PATH | split row (char esep) | prepend [
    # System & Package Managers
    "/opt/local/bin",
    "/usr/local/bin",
    "/usr/local/opt/node@22/bin",
    "/usr/local/opt/libpq/bin",
    "/usr/local/opt/trash/bin",
    "/usr/local/bin/Cursor",
    
    # User Binaries
    "($env.HOME)/.local/bin",
    "($env.HOME)/bin",
    "($env.HOME)/.cargo/bin",
    "($env.HOME)/go/bin",
    "($env.HOME)/miniconda3/bin",
    
    # NVM Node
    "($env.HOME)/.nvm/versions/node/v24.11.0/bin"
])

# --- Editor & Config ---
$env.EDITOR = "nvim"
$env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")

# --- Migrated Variables ---
$env.LDFLAGS = "-L/usr/local/opt/libpq/lib"
$env.CPPFLAGS = "-I/usr/local/opt/libpq/include"
$env.BAT_THEME = "base16"
$env.AERC_CONFIG_DIR = ($env.HOME | path join ".config" "aerc")
$env.TASKRC = ($env.HOME | path join ".config" "task" ".taskrc")
$env.NODE_OPTIONS = "--max-old-space-size=4096"
$env.NVM_DIR = ($env.HOME | path join ".nvm")

# --- Theme Configuration ---
$env.POSH_THEME = ($env.HOME | path join ".config" "oh-my-posh" "config.json")
