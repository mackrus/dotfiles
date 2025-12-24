# Dotfiles

My personal configuration files for macOS, managed as a bare git repository.

## Overview
- **OS**: macOS (Darwin)
- **Editor**: Neovim (Lua config)
- **Shell**: Zsh / Nushell
- **Terminals**: Ghostty, Kitty, Tmux
- **Tools**: Fastfetch, Btop, Bat, Sketchybar, Superfile

## Setup on a new machine

1. **Clone the repository as a bare repo:**
   ```bash
   git clone --bare git@github.com:mackrus/dotfiles.git $HOME/.dotfiles
   ```

2. **Define the alias in your current shell:**
   ```bash
   alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
   ```

3. **Checkout the content:**
   ```bash
   dot checkout
   ```
   *Note: You may need to back up or remove existing config files (like `.zshrc`) if they conflict.*

4. **Hide untracked files:**
   ```bash
   dot config --local status.showUntrackedFiles no
   ```

## Management
This repository uses a **allowlist** strategy. All files are ignored by default via `~/.gitignore`.
To add a new file:
```bash
dot add -f path/to/file
dot commit -m "Add new config"
dot push
```
