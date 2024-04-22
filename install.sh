pushd $HOME
git clone https://github.com/ktnlvr/dotfiles.git dotfiles
cd dotfiles
stow . --adopt
popd