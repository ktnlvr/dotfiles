zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
compinit

export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.cargo/env:$PATH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="fishy"

CASE_SENSITIVE="false"

zstyle ':omz:update' mode reminder

ENABLE_CORRECTION="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias dir='ls -lsah'
alias gc='git commit'
alias c='code-insiders'
alias gmend='git commit --amend --no-edit'

# compatibility with sudo scripts
alias sudo='doas'

eval "$(zoxide init zsh --cmd cd)"

startc() {
  if [ -n "$1" ]; then 
    mkdir -p $1
    cd $1
  else
    echo "No directory name provided, usage: startc <dirname>";
    return 1;
  fi

  git init
  mkdir -p src
  mkdir -p include
  echo -e "#include <stdio.h>\n\nint main(void) {\n  printf(\"Hello, world!\\\n\");\n}" > src/main.c
  echo "compile:\n\tmkdir -p build\n\tgcc src/main.c -Iinclude/ -o ./build/out" > makefile
  echo "BasedOnStyle: LLVM" > .clang-format
}
