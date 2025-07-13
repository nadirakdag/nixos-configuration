{ config, pkgs, ... }:

{

  imports = [
    <home-manager/nixos>
  ];

  home.username = "nadir";
  home.homeDirectory = "/home/nadir";
  home.stateVersion = "24.05";

  # Developer apps
  home.packages = with pkgs; [
    vscode brave git zsh
    direnv jq unzip curl wget
    hyprpaper waybar foot
    wl-clipboard grim slurp
    pavucontrol
    lxappearance
    nerdfonts
    catppuccin-gtk
    catppuccin-cursors.macchiatoDark
    catppuccin-waybar
  ];

  # Shell
  programs.zsh.enable = true;

  # Waybar
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "network" "tray" ];
      };
    };
    style = builtins.readFile ../waybar/style.css;
  };

  # Hyprland config
  xdg.configFile."hypr/hyprland.conf".source = ../hypr/hyprland.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = ../hypr/hyprpaper.conf;
  xdg.configFile."waybar/style.css".source = ../waybar/style.css;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    pictures = "${config.home.homeDirectory}/Pictures";
  };

}
