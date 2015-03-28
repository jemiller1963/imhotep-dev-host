#!/bin/bash
#
# Rails Ready
#
# Author: Josh Frye <joshfng@gmail.com>
# Licence: MIT
#
# Contributions from: Wayne E. Seguin <wayneeseguin@gmail.com>
# Contributions from: Ryan McGeary <ryan@mcgeary.org>
#
# http://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p0.tar.gz
shopt -s nocaseglob
set -e

ruby_version="2.1.5"
ruby_version_string="2.1.5"
ruby_source_url="http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.5.tar.gz"
ruby_source_tar_name="ruby-2.1.5.tar.gz"
ruby_source_dir_name="ruby-2.1.5"
script_runner=$(whoami)
railsready_path=$(cd && pwd)/railsready
log_file="$railsready_path/install.log"
system_os=`uname | env LANG=C LC_ALL=C LC_CTYPE=C tr '[:upper:]' '[:lower:]'`

control_c()
{
  echo -en "\n\n*** Exiting ***\n\n"
  exit 1
}

# trap keyboard interrupt (control-c)
trap control_c SIGINT

clear

echo "#################################"
echo "########## Rails Ready ##########"
echo "#################################"

#determine the distro
if [[ $system_os = *linux* ]] ; then
  distro_sig=$(cat /etc/issue)
  redhat_release='/etc/redhat-release'
  if [[ $distro_sig =~ ubuntu ]] ; then
    distro="ubuntu"
  else
      if [ -e $redhat_release ] ; then
          distro="centos"
      fi
  fi
elif [[ $system_os = *darwin* ]] ; then
  distro="osx"
    if [[ ! -f $(which gcc) ]]; then
      echo -e "\nXCode/GCC must be installed in order to build required software. Note that XCode does not automatically do this, but you may have to go to the Preferences menu and install command line tools manually.\n"
      exit 1
    fi
else
  echo -e "\nRails Ready currently only supports Ubuntu, CentOS and OSX\n"
  exit 1
fi

echo -e "\n\n"
echo "run tail -f $log_file in a new terminal to watch the install"

echo -e "\n"
echo "What this script gets you:"
echo " * Ruby $ruby_version_string"
echo " * Bundler, Passenger, and Rails gems"

echo -e "\nThis script is always changing."
echo "Make sure you got it from https://github.com/joshfng/railsready"

# Check if the user has sudo privileges.
sudo -v >/dev/null 2>&1 || { echo $script_runner has no sudo privileges ; exit 1; }


# Set whichRuby = rvm
whichRuby=2

echo -e "\n\n!!! Set to install RVM for user: $script_runner !!! \n"


echo -e "\n=> Creating install dir..."
cd && mkdir -p railsready/src && cd railsready && touch install.log
echo "==> done..."

echo -e "\n==> done running $distro specific commands..."

  echo -e "\n=> Installing RVM the Ruby enVironment Manager http://rvm.beginrescueend.com/rvm/install/ \n"
  curl -L https://get.rvm.io | bash >> $log_file 2>&1
  echo -e "\n=> Setting up RVM to load with new shells..."

  #if RVM is installed as user root it goes to /usr/local/rvm/ not ~/.rvm
    if [ -f ~/.bash_profile ] ; then
      if [ -f ~/.profile ] ; then
        echo 'source ~/.profile' >> "$HOME/.bash_profile"
      fi
    fi
    echo "==> done..."

    echo "=> Loading RVM..."

    if [ -f ~/.bashrc ] ; then
      source ~/.bashrc
    fi
    if [ -f ~/.bash_profile ] ; then
      source ~/.bash_profile
    fi
    if [ -f ~/.zshrc ] ; then
      source ~/.zshrc
    fi
    if [ -f /etc/profile.d/rvm.sh ] ; then
      source /etc/profile.d/rvm.sh
    fi

  echo "==> done..."


  echo -e "\n=> Installing Ruby $ruby_version_string (this will take a while)..."
  echo -e "=> More information about installing rubies can be found at http://rvm.beginrescueend.com/rubies/installing/ \n"
  rvm install $ruby_version >> $log_file 2>&1
  echo -e "\n==> done..."
  echo -e "\n=> Using $ruby_version and setting it as default for new shells..."
  echo "=> More information about Rubies can be found at http://rvm.beginrescueend.com/rubies/default/"
  rvm --default use $ruby_version >> $log_file 2>&1
  echo "==> done..."

# Reload bash or zsh
echo -e "\n=> Reloading shell so ruby and rubygems are available..."
if [ -f ~/.bashrc ] ; then
  source ~/.bashrc
elif [ -f ~/.zshrc ]; then
  source ~/.zshrc
fi
echo "==> done..."

echo -e "\n=> Updating Rubygems..."

gem update --system --no-ri --no-rdoc >> $log_file 2>&1

echo "==> done..."

echo -e "\n=> Installing Bundler, Passenger and Rails..."

gem install bundler passenger rails --no-ri --no-rdoc -f >> $log_file 2>&1

echo "==> done..."

echo -e "\n#################################"
echo    "### Installation is complete! ###"
echo -e "#################################\n"

echo -e "\n !!! logout and back in to access Ruby !!!\n"

echo -e "\n Thanks!\n-Josh\n"
