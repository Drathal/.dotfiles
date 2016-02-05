#!/bin/bash
dir=~/.dotfiles
backup=~/.dotfiles_old
files=".bashrc .bash_profile .gitignore .gitconfig docker-clean.sh git-prompt.sh"

COLOR_GREEN='\033[32m'
COLOR_PURPLE='\033[35m'
COLOR_YELLOW='\033[33m'
COLOR_CYAN='\033[36m'
COLOR_RED='\031[36m'
COLOR_NC='\033[0m'

echo "Creating backup directory: $backup"
mkdir -p $backup

cd $dir
for file in $files; do

    echo -ne " ★  ${COLOR_CYAN}~/$file: ${COLOR_NC}"

    if [ -f ~/$file ]; then
        echo -ne "${COLOR_GREEN}backup ✔${COLOR_NC} "
        mv ~/$file $backup
    fi

    if [ -f $dir/$file ]; then
        echo -ne "${COLOR_GREEN}linked ✔${COLOR_NC} "
        ln -s $dir/$file ~/$file
    fi

    echo " "

done
