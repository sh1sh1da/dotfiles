#!/bin/bash

DOTFILES=(.spacemacs .zshrc)
WORKDIR=`pwd`

for f in ${DOTFILES[@]}
do
    ln -fnsv $WORKDIR/$f ~/$f
done

if [ -e ~/.emacs.d ]; then
    mv ~/.emacs.d ~/.emacs.d.old
fi
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

for f in `ls $WORKDIR/spacemacs_private/`
do
    ln -s $WORKDIR/spacemacs_private/$f ~/.emacs.d/private/$f
done

if [ ! -d ~/.zplug ]; then
    curl -sL zplug.sh/installer | zsh
fi
