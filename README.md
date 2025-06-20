# Disk Formatting
```sh
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/nix/systems/david/disko.nix
```

# NixOS Installation
```sh
sudo nixos-install --no-root-password --flake /tmp/nix#david
sudo nixos-enter --root /mnt -c 'passwd luis'
reboot
```