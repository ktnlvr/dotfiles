export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="fishy"

CASE_SENSITIVE="true"

zstyle ':omz:update' mode reminder

ENABLE_CORRECTION="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

alias dir='ls -lsah'
alias gc='git commit'
alias c='code-insiders'
alias gmend='git commit --amend --no-edit'

eval "$(zoxide init zsh --cmd cd)"