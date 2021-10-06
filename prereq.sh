#!/bin/bash

# function to install homebrew
install_homebrew()
{
  # install homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Previous installations of Homebrew were through Ruby:
  #/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

# function to install the prerequisites
install_minikube()
{
  # verify Homebrew is installed, if it is, install minikube and related packages
  hash brew &>/dev/null &&
  brew update && brew install kubectl && brew cask install docker minikube virtualbox ||
    { echo "Homebrew is not installed"; install_homebrew; }
}

# check pre-reqs
hash docker docker-compose minikube kubectl &>/dev/null &&
echo -e "\nAll programs installed\n" ||
{ echo "At least one pre-requisite is missing.Installing now"; install_minikube; }

echo "All Done"
