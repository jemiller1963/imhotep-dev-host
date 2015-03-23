#!/bin/bash
   
   echo "======================================="
   echo "========= Cloning Rbenv ========="
   echo "======================================="

   cd
   git clone git://github.com/sstephenson/rbenv.git .rbenv
   echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
   echo 'eval "$(rbenv init -)"' >> ~/.bashrc
   for d in $HOME/.rbenv/bin $HOME/.rbenv/plugins/ruby-build/bin
	do test -d $d && PATH+=:$d ; done

   echo "======================================="
   echo "========= Cloning ruby build ========="
   echo "======================================="

   git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
   echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
   for d in $HOME/.rbenv/bin $HOME/.rbenv/plugins/ruby-build/bin
do test -d $d && PATH+=:$d ; done

   echo "======================================="
   echo "========= Installing Ruby with Rbenv ========="
   echo "======================================="
   rbenv install 2.1.2
   rbenv global 2.1.2
   rbenv rehash
   ruby -v