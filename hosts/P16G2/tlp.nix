{
  services.tlp = {
        enable = true;
        settings = {

          TLP_DEFAULT_MODE = "AC";
          TLP_PERSISTENT_DEFAULT = 0; # apply settings profile acccording to actual power source

          # Sound
          SOUND_POWER_SAVE_ON_AC = 1;
          SOUND_POWER_SAVE_ON_BAT = 1;

          SOUND_POWER_SAVE_CONTROLLER = "0";



          # Battery Care
          START_CHARGE_THRESH_BAT0 = 90; 
          STOP_CHARGE_THRESH_BAT0 = 100;

          NATACPI_ENABLE = 1;
          TPACPI_ENABLE = 1;
          TPSMAPI_ENABLE = 1;

          # Disks
          DISK_APM_LEVEL_ON_AC = "254 254";
          DISK_APM_LEVEL_ON_BAT = "128 128";


          # File system
          DISK_IDLE_SECS_ON_AC = 0;
          DISK_IDLE_SECS_ON_BAT = 2;

          MAX_LOST_WORK_SECS_ON_AC = 15;
          MAX_LOST_WORK_SECS_ON_BAT = 60;

          # GPU
          RADEON_DPM_PERF_LEVEL_ON_AC = "high";
          RADEON_DPM_PERF_LEVEL_ON_BAT = "low";

          RADEON_POWER_PROFILE_ON_AC = "high";
          RADEON_POWER_PROFILE_ON_BAT = "low";

          AMDGPU_ABM_LEVEL_ON_AC = 0;
          AMDGPU_ABM_LEVEL_ON_BAT = 4; 

          


          NMI_WATCHDOG = 0;


          # Networking
          WIFI_PWR_ON_AC = "on";
          WIFI_PWR_ON_BAT = "on";

          WOL_DISABLE = "Y"; # Disable Wake-on-LAN

          # Platform
          PLATFORM_PROFILE_ON_AC = "performance";
          PLATFORM_PROFILE_ON_BAT = "low-power";

          MEM_SLEEP_ON_AC = "s2idle";
          MEM_SLEEP_ON_BAT = "deep";

          # CPU
          CPU_DRIVER_OPMODE_ON_AC = "active";
          CPU_DRIVER_OPMODE_ON_BAT = "guided";

          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

          CPU_SCALING_MIN_FREQ_ON_AC = 0;
          CPU_SCALING_MAX_FREQ_ON_AC = 9999999;
          CPU_SCALING_MIN_FREQ_ON_BAT = 0;
          CPU_SCALING_MAX_FREQ_ON_BAT = 9999999;

          CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
          CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

          CPU_BOOST_ON_AC = 1;
          CPU_BOOST_ON_BAT = 0;


          # Radio Device Switching
          RESTORE_DEVICE_STATE_ON_STARTUP = 0;

          # Radio Device Wizard
          DEVICES_TO_DISABLE_ON_LAN_CONNECT = "wifi wwan";
          DEVICES_TO_DISABLE_ON_WIFI_CONNECT = "wwan";
          DEVICES_TO_DISABLE_ON_WWAN_CONNECT = "wifi";

          DEVICES_TO_ENABLE_ON_LAN_DISCONNECT = "wifi wwan";
          DEVICES_TO_ENABLE_ON_WIFI_DISCONNECT = "";
          DEVICES_TO_ENABLE_ON_WWAN_DISCONNECT = "";

          # DEVICES_TO_ENABLE/DISABLE_ON_DOCK
          DEVICES_TO_ENABLE_ON_DOCK = "";
          DEVICES_TO_DISABLE_ON_DOCK = "";

          DEVICES_TO_ENABLE_ON_UNDOCK = "";
          DEVICES_TO_DISABLE_ON_UNDOCK = "";

          # Runtime Power Management and ASPM
          RUNTIME_PM_ON_AC = "on";
          RUNTIME_PM_ON_BAT = "auto";

          PCIE_ASPM_ON_AC = "default";
          PCIE_ASPM_ON_BAT = "default";


          USB_AUTOSUSPEND = 1;
          USB_EXCLUDE_AUDIO = 1;
          USB_EXCLUDE_BTUSB = 1;
          USB_EXCLUDE_PHONE = 1;
          USB_EXCLUDE_PRINTER = 1;
          USB_EXCLUDE_WWAN = 0;
          USB_AUTOSUSPEND_DISABLE_ON_SHUTDOWN = 1;
        };
  };
}
