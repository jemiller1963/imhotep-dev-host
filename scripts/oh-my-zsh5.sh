#!/bin/bash
#
printf "\n***Installing Oh-My-Zsh"
# wget --no-check-certificate http://install.ohmyz.sh -O - | sh
# chsh vagrant -s /bin/zsh

# git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# chsh -s /bin/zsh

# Added zsh shell
echo -e "\n=> Installing zsh..."
sudo apt-get install zsh -yq
echo -e "\n=> INstalling oh-my-zsh..."
wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
echo -e "\n=> Setting shell to zsh..."
sudo chsh -s /bin/zsh vagrant
zsh
# echo -e "\n=> Setting default theme..."
# # Change the oh my zsh default theme.
# sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="3den"/g' ~/.zshrc
echo -e "\n=> Done..."