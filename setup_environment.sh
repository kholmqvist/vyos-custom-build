#!/bin/bash

function install_docker() {
  # Add Docker's official GPG key:
  sudo apt-get update
  sudo apt-get install -y ca-certificates curl gnupg
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  
  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
 
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  
  sudo usermod -aG docker $USER
}


function check_software() {
  # Check if git is installed
  if ! [ -x "$(command -v git)" ]; then
    sudo apt-get install -y git
  fi

  # Check if docker is installed
  if ! [ -x "$(command -v docker)" ]; then
    install_docker
  fi
}

function current() {
  # Check for required software. Git & Docker
  check_software

  # For VyOS 1.5 (circinus, current)
  git clone -b current --single-branch https://github.com/vyos/vyos-build $HOME/vyos-build-current
  
  # Add this alias to bash
  echo "alias vybld_current='docker pull vyos/vyos-build:current && docker run --rm -it \
     -v "$HOME/vyos-build-current":/vyos \
     -v "$HOME/.gitconfig":/etc/gitconfig \
     -v "$HOME/.bash_aliases":/home/vyos_bld/.bash_aliases \
     -v "$HOME/.bashrc":/home/vyos_bld/.bashrc \
     -w /vyos --privileged --sysctl net.ipv6.conf.lo.disable_ipv6=0 \
     -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
     vyos/vyos-build:current bash'" >> $HOME/.bash_aliases

  # Reload bash
  source $HOME/.bash_aliases

  # Let user know we're ready to build
  echo "You're now ready to build VyOS. You can now run the command: vybld_sagitta"
}


function equuleus() {
  # Check for required software. Git & Docker
  check_software

  # For VyOS 1.3 (equuleus)
  git clone -b equuleus --single-branch https://github.com/vyos/vyos-build $HOME/vyos-build-equuleus
  
  # Add this alias to bash
  echo "alias vybld_equuleus='docker pull vyos/vyos-build:equuleus && docker run --rm -it \
     -v "$HOME/vyos-build-equuleus":/vyos \
     -v "$HOME/.gitconfig":/etc/gitconfig \
     -v "$HOME/.bash_aliases":/home/vyos_bld/.bash_aliases \
     -v "$HOME/.bashrc":/home/vyos_bld/.bashrc \
     -w /vyos --privileged --sysctl net.ipv6.conf.lo.disable_ipv6=0 \
     -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
     vyos/vyos-build:equuleus bash'" >> $HOME/.bash_aliases

  # Reload bash
  source $HOME/.bash_aliases

  # Let user know we're ready to build
  echo "You're now ready to build VyOS. You can now run the command: vybld_sagitta"
}


function sagitta() {
  # Check for required software. Git & Docker
  check_software

  # For VyOS 1.4 (sagitta)
  git clone -b sagitta --single-branch https://github.com/vyos/vyos-build $HOME/vyos-build-sagitta
  
  # Add this alias to bash
  echo "alias vybld_sagitta='docker pull vyos/vyos-build:sagitta && docker run --rm -it \
     -v "$HOME/vyos-build-sagitta":/vyos \
     -v "$HOME/.gitconfig":/etc/gitconfig \
     -v "$HOME/.bash_aliases":/home/vyos_bld/.bash_aliases \
     -v "$HOME/.bashrc":/home/vyos_bld/.bashrc \
     -w /vyos --privileged --sysctl net.ipv6.conf.lo.disable_ipv6=0 \
     -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
     vyos/vyos-build:sagitta bash'" >> $HOME/.bash_aliases

  # Reload bash
  source $HOME/.bash_aliases

  # Let user know we're ready to build
  echo "You're now ready to build VyOS. You can now run the command: vybld_sagitta"
}

function menu() {
  # Menu
  echo "This script is made to prepare your Debian based distribution for building VyOS"
  echo ""
  echo "Usage: $0 OPTION"
  echo ""
  echo "OPTIONS:"
  echo "  docker    # Install docker"
  echo "  current   # Setup environment for VyOS 1.5/Current development branch"
  echo "  equuleus  # Setup environment for VyOS 1.3 Equuleus"
  echo "  sagitta   # Setup environment for VyOS 1.4 Sagitta"
  echo ""
}

if [ $# -eq 0 ]
then
	menu
else
	$1
fi
