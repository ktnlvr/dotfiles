#!/bin/bash

echo "ktnlvr's dotfiles coming right up!"

if [ ! -d "$HOME" ]; then
  echo "\$HOME not defined, aborting"
  exit 0
fi

if [ -d "$HOME/.dotfiles" ]; then
    echo "\$HOME/.dotfiles already exists, updating..."
    git -C $HOME/.dotfiles fetch --progress || { exit $?; }
    echo "updates pulled!"
else
    echo "pulling data to \$HOME/.dotfiles"
    git clone https://github.com/ktnlvr/dotfiles.git $HOME/.dotfiles --progress || { exit $?; }
fi

echo "running stow..."
stow . -d $HOME/.dotfiles --adopt || { exit $?; }

echo "done! enjoy my configs"
echo "            - ktnlvr  "
