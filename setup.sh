#!/usr/bin/env bash

set -e

dotfiles=(
  bashrc
  gitconfig
  gitignore
  vim
  vimrc
)

# Create dotfiles_old in homedir
echo -n "Creating ~/dotfiles_old for backup of any existing dotfiles."
mkdir -p ~/dotfiles_old
echo "done"
# Move any existing dotfiles in homedir to dotfiles_old directory,
# # then create symlinks from the homedir to any files in the ~/dotfiles
# # directory specified in $files
for dotfile in "${dotfiles[@]}" do
  echo "Moving existing $dotfile from ~ to dotfiles_old/ plus timestamp"
  mv ~/.$file ~/dotfiles_old/$(date +"%Y%m%d")
done

for dotfile in "${dotfiles[@]}"
do
  printf "Linking $dotfile with: ln -sf $HOME/dotfiles/$dotfile .$dotfile\n"
  ln -sf $HOME/dotfiles/$dotfile .$dotfile
done

# Vim things.
if [ ! -d $HOME/.vim/bundle/Vundle.vim ];
then
  printf "\nInstalling vundle with: git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim\n"
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim

  printf "Installing vundle plugins with: vim -c PluginInstall -c quitall\n"
  vim -c PluginInstall -c quitall

  if hash apt-get 2>/dev/null; then
    printf "Trying to install YCM pre-requisites with apt-get\n"
    sudo apt-get install -y build-essential cmake python-dev python3-dev
  else
    printf "Trying to install YCM pre-requisites with dnf\n"
    sudo dnf install build-essential cmake python-dev python3-dev
  fi

  printf "Compiling YCM\n"
  cd ~/.vim/bundle/YouCompleteMe
  ./install.py
  cd -
else
  printf "\nAlready installed vundle?; skipping vim setup steps\n"
fi

# Install anaconda.
if [ ! -d $HOME/anaconda3 ];
then
  printf "\nInstalling anaconda\n"
  wget https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh
  bash Anaconda3-4.2.0-Linux-x86_64.sh
  rm Anaconda3-4.2.0-Linux-x86_64.sh
else
  printf "\nAlready installed anaconda3? skipping python setup steps\n"
fi

