# nixos-pi-custom-image
A nix configuration to build a custom NixOS image for aarch64 devices (Raspberry Pis, etc).

## Usage

To build on NixOS, add `boot.binfmt.emulatedSystems = [ "aarch64-linux" ];` to your host configuration and `sudo nixos-rebuild test` to enable building of aarch64 images on a non-aarch64 host.

Place the configuration for the system into the `nixos` directoy and then run the `./build_image.sh` script. The `nixos` directory is used to setup the image and is included into the image as `/etc/nixos/`.

# Limitations

There is a flaw where the files in /etc/nixos are removed when `nixos-rebuild` is run on the built image. I worked around this by copying the config out and copying it back in after the rebuild.

```shell
sudo cp -rp /etc/nixos ~/nixos
sudo nixos-rebuild switch
sudo cp -rp ~/nixos /etc/nixos
```
