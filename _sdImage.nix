# Uses the configuration to build an SD card image
{ config, lib, ... }:
let
  # what directory (relative to this file) to use to configure the image and install into /etc/nixos in the image
  source_dir = ./nixos;
  # the file within source_dir that is the root of configuration for this iamge
  source_root_file = "configuration.nix";

in {
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix> # build an SD card .img
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix> # include a baseline nix-channel
    "${source_dir}/${source_root_file}"
  ];

  config = {
    # include the source nix files in the built image
    environment.etc = {
      nixos = {
        source = "${lib.sources.trace source_dir}/*";
        mode = "660"; # setting this to something other than "symlink" copies the files to /etc/nixos rather symlinking
        user = "root";
        group = "wheel";
      };
    };

    sdImage = {
      imageBaseName = (builtins.baseNameOf ./.);
      compressImage = false;
    };
  };
}
