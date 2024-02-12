#!/usr/bin/env sh

img_link_name="latest.img"

nix-build '<nixpkgs/nixos>' -A config.system.build.sdImage -I nixpkgs=channel:nixos-23.11 -I nixos-config=./_sd-image.nix --argstr system aarch64-linux

if [ $? -eq 0 ]; then
  # make a link to the built image
  fileName=$(find result/sd-image -name '*.img')
  rm -f $img_link_name ; ln -s $fileName $img_link_name
fi
