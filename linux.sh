#!/usr/bin/env bash

# Softwares
echo 'Instalando pacotes do usuário'
sudo apt install -y $(cat packages/user.txt)

# Snaps
echo 'Instalando snaps'
sudo snap install $(cat packages/snaps-user.txt)
sudo snap install --beta authy

# Unused softwares
echo 'Removendo pacotes não utilizados'
sudo apt purge -y $(cat packages/unused.txt)

# Unused snaps
echo 'Removendo snaps não utilizados'
sudo snap remove $(cat packages/snaps-unused.txt)

# Clean packages
echo 'Limpando cache do repositório de pacotes'
sudo apt update
sudo apt upgrade -y
sudo apt clean

# Pastas
echo 'Criando pastas'
mkdir ~/.cache/fish_compare
mkdir ~/.local/bin

# Fish
echo 'Configurando o fish shell'
sudo chsh -s /usr/bin/fish impsid
./initial-settings.fish

# Date and time
echo 'Alterando funcionamento do relógio do sistema'
timedatectl set-local-rtc true

# KVM
echo 'Adicionando usuário ao grupo das máquinas virtuais'
sudo adduser impsid kvm

# DConf settings
echo 'Restaurando configurações via DConf'
dconf load / < settings.ini

