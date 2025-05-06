#! /bin/bash

# Install for working nix machines
set -euox pipefail

# read two input values, name and email
echo "Enter your name:"
read name
echo "Enter your email@gmail.com:"
read email

# mkdir if doesn't exist
mkdir -p ~/.vim/after/syntax
mkdir -p ~/.config/

# generate symbolic links
ln -s -i ${PWD}/vimrc ~/.vimrc
ln -s -i ${PWD}/vimwiki.vim ~/.vim/after/syntax/vimwiki.vim
ln -s -i ${PWD}/bash_aliases ~/.bash_aliases
ln -s -i ${PWD}/tmux.conf ~/.tmux.conf

# if input is empty, then skip
if [ -z "$name" ]; then
    echo "Input name is empty, skipping linking .gitconfig ..."
else
    # replace name in gitconfig
    echo name is $name
    echo email is $email
    cp gitconfig my_gitconfig
    sed -i "s/a_name/$name/g" my_gitconfig
    sed -i "s/an_email/$email/g" my_gitconfig
    ln -s -i ${PWD}/my_gitconfig ~/.gitconfig
fi

# if Nix is installed
if command -v home-manager &> /dev/null
then
    echo "home-manager is already installed"
    ln -s -i  ${PWD}/home.nix ~/.config/home-manager/home.nix
else
    echo "Please install home-manager"
fi

# if starship is not installed install it
if command -v starship &> /dev/null
then
    echo "starship is already installed"
    eval "$(starship init bash)"
else
    echo "Please install starship"
fi

