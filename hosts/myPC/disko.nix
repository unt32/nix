{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/nmvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "512M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "fmask=0077"
                  "dmask=0077"
                ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
    nodev = {
      ssd1tb = {
        device = "/dev/disk/by-uuid/28597bcb-f822-4bbf-b458-6ee3720ab133";
        fsType = "ext4";
        mountpoint = "/mnt/SSD1TB";
      };
      hdd500gb = {
        device = "/dev/disk/by-uuid/92e58c25-c20d-478c-9c6f-7a8a50a3fcad";
        fsType = "ext4";
        mountpoint = "/mnt/HDD500GB";
      };
    };
  };
}
