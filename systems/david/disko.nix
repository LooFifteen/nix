{
  disko.devices = {
    # main disk
    disk.main = {
      type = "disk";
      device = "/dev/disk/by-diskseq/1";
      content = {
        type = "gpt";
        partitions = {
          # efi
          esp = {
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "defaults" ];
            };
          };

          # encrypted root
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "encrypted";
              settings.allowDiscards = true;
              content = {
                type = "lvm_pv";
                vg = "pool";
              };
            };
          };
        };
      };
    };

    # lvm pool
    lvm_vg.pool = {
      type = "lvm_vg";
      lvs = {
        # swap
        swap = {
          size = "8G";
          content.type = "swap";
        };

        # root
        root = {
          size = "100%FREE";
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];

            subvolumes =
              let
                mountOptions = [
                  "compress=zstd"
                  "noatime"
                  "nodiratime"
                  "discard"
                ];
              in
              {
                # root
                "/" = {
                  inherit mountOptions;
                  mountpoint = "/";
                };

                # home
                "/home" = {
                  inherit mountOptions;
                  mountpoint = "/home";
                };

                # nix
                "/nix" = {
                  inherit mountOptions;
                  mountpoint = "/nix";
                };
              };
          };
        };
      };
    };
  };
}