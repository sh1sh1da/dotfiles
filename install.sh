#!/bin/bash

DOTFILES=(.spacemacs .zshrc)

for f in ${DOTFILES[@]}
do
    ln -fnsv ./$f ~/$f
done

git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
for f in `ls ./spacemacs_private/`
do
    ln -s ./spacemacs_private/$f ~/.emacs.d/private/$f
done

if [ ! -d ~/.zplug ]; then
    curl -sL zplug.sh/installer | zsh
fi
