#!/usr/bin/env sh

cd /home/unt32/nix
cp /etc/nixos/hardware-configuration.nix ./nixos/hardware-configuration.nix
sudo nixos-rebuild switch --flake ./
home-manager switch --flake ./
