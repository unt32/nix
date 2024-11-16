{ pkgs, ...}: {
  services.blueman.enable = true;
    environment.systemPackages = with pkgs; [bluez bluez-tools];
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      #package = pkgs.bluez5-experimental;
      package = pkgs.bluez;
      settings.Policy.AutoEnable = "true";
      settings.General = {
          Enable = "Source,Sink,Media,Socket";
          Name = "Hello";
          ControllerMode = "dual";
          FastConnectable = "true";
          Experimental = "true";
          KernelExperimental = "true";
      };
    };
}