#/bin/bash

## neovim
mkdir -p .config
ln -sf dotfiles/nvim .config/nvim

## vim (legacy)
ln -sf dotfiles/.vimrc .vimrc
ln -sf dotfiles/.vimrc.coc .vimrc.coc
ln -sf dotfiles/.vimrc.plugged .vimrc.plugged
ln -sf dotfiles/.vim .vim

## zsh
ln -sf dotfiles/.zshrc .zshrc
ln -sf dotfiles/.zshrc.alias .zshrc.alias
ln -sf dotfiles/.oh-my-zsh .oh-my-zsh
