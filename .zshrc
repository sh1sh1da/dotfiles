## 環境変数
export LANG=ja_JP.UTF-8
export LSCOLORS=gxfxcxdxbxegedabagacad
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=10000
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

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

PROMPT="%{${fg[magenta]}%}[%n@%m]}%{${fg[blue]}%} %~"' ${vcs_info_msg_0_}'"
$ "

# Alias
alias ls='ls -G'
alias cd-git='cd `ghq list -p | peco`'
