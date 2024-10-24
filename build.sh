#!/usr/bin/env sh

cd /home/unt32/nix || exit 1
cp /etc/nixos/hardware-configuration.nix ./nixos/hardware-configuration.nix || exit 1
sudo nixos-rebuild switch --flake ./ || exit 1
home-manager switch --flake ./
