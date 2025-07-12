{ pkgs, ... }:

{
  ###########################################################################
  # 1.  Basic system setup
  ###########################################################################
  networking.hostName = "nixos-hypr";
  time.timeZone       = "Europe/Amsterdam";
  console.keyMap      = "trq";  # Turkish Q layout


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ###########################################################################
  # 2.  User with a hashed password
  ###########################################################################
  users.users.nadir = {
    isNormalUser = true;
    extraGroups  = [ "wheel" ];         # sudo privileges
    hashedPassword = ""; 
    shell = pkgs.zsh;
    # ↑ Replace with **your** hash – see “How to generate” below.
  };

  ###########################################################################
  # 3.  Display manager (SDDM) in Wayland mode
  ###########################################################################
  services.xserver.enable                       = true;
  services.xserver.displayManager.sddm.enable   = true;
  services.xserver.displayManager.sddm.wayland.enable = true;

  ###########################################################################
  # 4.  Hyprland
  ###########################################################################
  programs.home-manager.enable = true;


  ###########################################################################
  # 6.  Optional: Enable sound (PipeWire) and networking
  ###########################################################################
  sound.enable            = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable  = true;
    jack.enable  = true;
  };

  networking.networkmanager.enable = true;

  # Set GTK theme for all users (Catppuccin Mocha)
  environment.variables = {
    GTK_THEME = "Catppuccin-Mocha-Standard-Blue-Dark";
    XCURSOR_THEME = "Catppuccin-Macchiato-Dark-Cursors";
  };

  # Set default shell to zsh system-wide (optional)
  programs.zsh.enable = true;

  # Enable VirtualBox Guest Additions
  services.virtualboxGuest.enable = true;
  
  # Ensure necessary kernel modules are loaded
  boot.extraModulePackages = with config.boot.kernelPackages; [ 
    virtualboxGuestAdditions 
  ];

  # Optional: Clipboard and drag & drop (host ↔ guest)
  virtualisation.virtualbox.guest.enable = true;

  # If you use X11 apps within Wayland
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
}


