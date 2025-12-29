export PATH="/opt/local/bin:$PATH"
# zsh aliases
alias cc="nvim ~/.zshrc"
alias cs="source ~/.zshrc"

# alias ohmyzsh="mate ~/.oh-my-zsh"
export LDFLAGS="-L/usr/local/opt/libpq/lib"
export CPPFLAGS="-I/usr/local/opt/libpq/include"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export DYLD_LIBRARY_PATH="/usr/local/Cellar/postgresql@14/14.17_1/lib/postgresql@14:$DYLD_LIBRARY_PATH"

# source $HOME/.config/broot/launcher/bash/br

# ####################################################################
# PATHS---------------------------------------------------------------
# ####################################################################
## Conda path
export PATH="$HOME/miniconda3/bin:$PATH"

# Cursor path
export PATH="$PATH:/usr/local/bin/Cursor"

# >>> conda initialize >>>
# !! Contents within this block are managed by "conda init" !!
# __conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
# if [ $? -eq 0 ]; then
#   eval "$__conda_setup"
# else
#   if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
#     . "$HOME/miniconda3/etc/profile.d/conda.sh"
#   else
#     export PATH="$HOME/.local/share/uv/python/cpython-3.13.2-macos-x86_64-none/bin/python3.13:$PATH"
#   fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

# Superfile cd functionality
spf() {
  os=$(uname -s)

  # Linux
  if [[ "$os" == "Linux" ]]; then
    export SPF_LAST_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/superfile/lastdir"
  fi

  # macOS
  if [[ "$os" == "Darwin" ]]; then
    export SPF_LAST_DIR="$HOME/Library/Application Support/superfile/lastdir"
  fi

  command spf "$@"

  [ ! -f "$SPF_LAST_DIR" ] || {
    . "$SPF_LAST_DIR"
    rm -f -- "$SPF_LAST_DIR" >/dev/null
  }
}

# Created by pipx on 2024-11-17 17:48:50
export PATH="$PATH:$HOME/.local/bin"

# python uv PATH
export PATH="$HOME/.local/share/uv/python/cpython-3.14.2-macos-x86_64-none/bin:$PATH"

# Golang
export PATH=$PATH:~/go/bin

# superfile
# nvim-cd is for spf to cd to current dir before editing with hotkey "e"
export PATH="$HOME/bin:$PATH"

# nodejs
export PATH="/usr/local/opt/node@22/bin:$PATH"

# ####################################################################
# PATHS--END----------------------------------------------------------
# ####################################################################

######################################################################
#*********************** standard stuff ***********************
#**************************************************************
######################################################################

# source env variables
source ~/.env

#######################################################################
#
#                       Packages found online
#
#######################################################################

## Gemini
alias g="gemini"

# Nvim
# custom settings
export EDITOR="nvim"

# bat text highlighting
export BAT_THEME=base16

# fzf fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Start tmux with neofetch and btop, using custom config
if [[ -z "$TMUX" ]]; then
  tmux -f ~/.config/tmux/tmux.conf attach-session -t mac || tmux -f ~/.config/tmux/tmux.conf new-session -s mac
fi

# aerc email client
export AERC_CONFIG_DIR="$HOME/.config/aerc"
alias aerc="aerc -C "\$AERC_CONFIG_DIR/aerc.conf" -A "\$AERC_CONFIG_DIR/accounts.conf" -B "\$AERC_CONFIG_DIR/binds.conf""

#gpg kechain
export GPG_TTY=$(tty)

# oh my zsh
source $HOME/.config/oh-my-zsh/.zshrc_conf

# task (todo-tool)
export TASKRC=~/.config/task/.taskrc

# github completion
# fpath=(~/.zsh/completions $fpath)
# autoload -Uz compinit
# compinit

# node.js memory issues fix
export NODE_OPTIONS="--max-old-space-size=4096"

 # nice zsh powerbar oh-my-posh
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/config.json)"

alias n=nvim

# Show dotfiles in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/usr/local/opt/trash/bin:$PATH"
alias dot="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# Load local/private config
[ -f ~/.zshrc_local ] && source ~/.zshrc_local
