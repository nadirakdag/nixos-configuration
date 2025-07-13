{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./users/nadir.nix
    <home-manager/nixos>
  ];

  # Basic system
  networking.hostName = "nixos-hypr-poc";
  time.timeZone       = "Europe/Amsterdam";
  i18n.defaultLocale  = "en_US.UTF-8";

  #keyboard
  console.keyMap      = "trq";  # Turkish Q layout
  services.xserver.xkb = {
    layout = "tr";
    variant = "";
  };

  
  
  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # User definition
  users.users.nadir = {
    isNormalUser = true;
    extraGroups  = [ "wheel" "networkmanager" ];
    hashedPassword = "";
    shell = pkgs.zsh;
  };

  # Display manager + Hyprland
  programs.hyprland.enable = true;

  # Networking, audio
  networking.networkmanager.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };

  # Enable home-manager as NixOS module
  programs.home-manager.enable = true;

  environment.variables = {
    GTK_THEME = "Catppuccin-Mocha-Standard-Blue-Dark";
    XCURSOR_THEME = "Catppuccin-Macchiato-Dark-Cursors";
  };

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

  system.stateVersion = "25.05";
}
