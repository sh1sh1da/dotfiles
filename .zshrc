## 環境変数
export LANG=ja_JP.UTF-8
export LSCOLORS=gxfxcxdxbxegedabagacad
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=10000
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.rbenv/bin
export PATH=$PATH:$HOME/.nodebrew/current/bin

# rbenv
eval "$(rbenv init -)"

## zplug
# Install zplug Settings
source ~/.zplug/init.zsh

# 補完
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'

# ハイライト
zplug 'zsh-users/zsh-syntax-highlighting'

# Install plugins
if ! zplug check --verbose; then
  printf 'Install? [y/N]: '
  if read -q; then
    echo; zplug install
  fi
fi
zplug load --verbose

## プロンプト
# Get git info
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

PROMPT="%(?.%{${fg[magenta]}%}.%{${fg[red]}%})[%n@%m]%{${reset_color}%} %~"' ${vcs_info_msg_0_}'"
$ "

# Alias
alias ls='ls -G'
alias cd-git='cd `ghq list -p | peco`'


## peco 系
# history
function select_history_with_peco() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
}
zle -N select_history_with_peco
bindkey '^R' select_history_with_peco

# find directories
function find_dir_with_peco() {
    local current_buffer=$BUFFER
    local selected_dir="$(find ~ -maxdepth 5 -type d | peco)"
    if [ -d "$selected_dir" ]; then
        BUFFER=$current_buffer$selected_dir
        CURSOR=$#BUFFER
    fi
}
zle -N find_dir_with_peco
bindkey '^x^d' find_dir_with_peco

# find files
function find_file_with_peco() {
    local current_buffer=$BUFFER
    local selected_file="$(find ~ -maxdepth 5 -type f | peco)"
    if [ -f "$selected_file" ]; then
        BUFFER=$current_buffer$selected_file
        CURSOR=$#BUFFER
    fi
}
zle -N find_file_with_peco
bindkey '^x^f' find_file_with_peco

# move to dir
function move_to_dir_with_peco() {
    local current_buffer=$BUFFER
    local selected_dir="$(find ~ -maxdepth 5 -type d | peco)"
    if [ -d "$selected_dir" ]; then
        BUFFER="pushd $current_buffer$selected_dir"
        CURSOR=$#BUFFER
        zle accept-line
    fi
}
zle -N move_to_dir_with_peco
bindkey '^xd' move_to_dir_with_peco

# open file with vscode
function code_with_peco() {
    local current_buffer=$BUFFER
    local selected_file="$(find ~ -maxdepth 5 -type f | peco)"
    if [ -f "$selected_file" ]; then
        BUFFER="code $current_buffer$selected_file"
        CURSOR=$#BUFFER
        zle accept-line
    fi
}
zle -N code_with_peco
bindkey '^o' code_with_peco
