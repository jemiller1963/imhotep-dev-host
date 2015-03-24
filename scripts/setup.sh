#!/usr/bin/env bash

printf "\n****Provisioning virtual machine..."

printf "\n****Updating apt-get\n"
sudo apt-get update -yq && sudo apt-get upgrade -yq && sudo apt-get dist-upgrade -yq

printf "\n****Installing core tools"
sudo apt-get install git-core curl zlib1g-dev libssl-dev libxml2 libxml2-dev libxslt1-dev -yq

# printf "\n****Installing zsh"
# apt-get install zsh -yq
# sudo chsh -s $(which zsh) $(whoami)

# printf "\n***Installing Oh-My-Zsh"
# wget --no-check-certificate http://install.ohmyz.sh -O - | sh
# chsh vagrant -s /bin/zsh

printf "\n****Installing Git"
apt-get install git -yq

#================== zsh =====================

##
# ZSH
##
printf "\n========== Installing zsh ==============="
# Install zsh
apt-get install -y -q zsh
printf "\n========== Done ===============\n"
printf "\n========== Installing oh-my-zsh ==============="
# Clone oh-my-zsh
if [ ! -d ~vagrant/.oh-my-zsh ]; then
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~vagrant/.oh-my-zsh
fi

# Create a new zsh configuration from the provided template
cp ~vagrant/.oh-my-zsh/templates/zshrc.zsh-template ~vagrant/.zshrc

# Change ownership of .zshrc
chown vagrant: ~vagrant/.zshrc

# Customize theme
sed -i -e 's/ZSH_THEME=".*"/ZSH_THEME="philips"/' ~vagrant/.zshrc

# add aliases ****** ERROR --> home/vagrant/.zshrc:source:78: no such file or directory: /home/vagrant/.bash_aliases
# sed -i -e 's/# Example aliases/source ~\/.bash_aliases/gi' ~vagrant/.zshrc

# Set zsh as default shell
chsh -s /bin/zsh vagrant
printf "\n========== Done installing zsh ==============="


printf "\n****Installing Docker"
# sudo apt-get install -yq docker.io
wget -qO- https://get.docker.com/ | sh

printf "\n****Adding user vagrant to group docker"
sudo usermod -a -G docker vagrant

# printf "\n****Installing pip"
# sudo apt-get install -yq python-pip && sudo easy_install -U pip

# printf "\n****Installing fig"
# sudo pip install -U fig

printf "\n****Installing Compose"
curl -L https://github.com/docker/compose/releases/download/1.1.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
printf "=== Test Installation of Compose"
docker-compose --version
printf "\n**** Done *****"


printf "\n****Cleanup"
apt-get clean && apt-get autoremove -yq && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

printf "\n========= Cleanup Complete ==============="

# printf "\n*****Install Cucumber"
# sudo apt-get install -y cucumber