#!/bin/bash

echo ">>> Installing Oh-My-Zsh"
#
su -c "git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh" vagrant
su -c "cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc" vagrant
echo "\nsource ~/.nvm/nvm.sh" >> /home/vagrant/.zshrc
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="lambda"/g' /home/vagrant/.zshrc
chsh -s /bin/zsh vagrant