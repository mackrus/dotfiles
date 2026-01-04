# config.nu
# Nushell Main Configuration

# --- Core Settings ---
$env.config = ($env.config | merge {
    show_banner: false
    table: {
        mode: rounded
        index_mode: auto
        padding: { left: 1, right: 1 }
        trim: {
            methodology: wrapping
            wrapping_try_keep_words: true
            truncating_suffix: "..."
        }
    }
    ls: {
        use_ls_colors: true
        clickable_links: true
    }
    cursor_shape: {
        vi_insert: line
        vi_normal: block
        emacs: line
    }
    footer_mode: 25
})

# --- Aliases ---
alias g = gemini
alias cc = nvim ~/.config/nushell/config.nu
alias jobsearch = /usr/local/bin/job_search_cli.sh
alias gmail-clean = uv run --project ($env.HOME + "/.gmail-cleaner") python ($env.HOME + "/.gmail-cleaner/main.py")
alias uvinit = uv run --project ($env.HOME + "/Documents/Programmering/python/proj_setup_uv_git_init") python ($env.HOME + "/Documents/Programmering/python/proj_setup_uv_git_init/main.py")
alias gqc = git-quick-commit.sh
alias n = nvim
alias face = uv run --project ($env.HOME + "/Documents/Programmering/python/face_recog/face") python ($env.HOME + "/Documents/Programmering/python/face_recog/face/main.py")

# --- Custom Commands ---

# Project Init
def --env myinit [name: string] {
    let setup_script = ($env.HOME | path join 'Documents/Programmering/python/proj_setup_uv_git_init/main.py')
    uv run --active $setup_script $name
    if ($name | path exists) {
        cd $name
        uv pip freeze | save -f requirements.txt
    }
}

# Smart Open
def --env o [file: string] {
    let ext = ($file | path parse | get extension | str downcase)
    if $ext == "pdf" {
        ^tdf $file
    } else {
        ^nvim-cd $file
    }
}

# Superfile Wrapper (Fixes cd-on-quit for Nushell)
def --env spf [...args] {
    let last_dir_path = ($env.HOME | path join 'Library/Application Support/superfile/lastdir')
    
    with-env { SPF_LAST_DIR: $last_dir_path } {
        ^spf ...$args
    }
    
    if ($last_dir_path | path exists) {
        let raw_cmd = (open $last_dir_path | str trim)
        # Parse out the path from: cd '/foo/bar'
        let clean_path = ($raw_cmd | split row "'" | get 1)
        
        if ($clean_path | path exists) {
            cd $clean_path
        }
        rm $last_dir_path
    }
}

# --- Prompt Initialization ---
source ~/.config/nushell/prompt.nu
