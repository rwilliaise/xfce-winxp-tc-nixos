# Windows XP Total Conversion Nix Flake
This repository provides a (currently incomplete) Nix flake that build the
packages from the
[rozniak/xfce-winxp-tc](https://github.com/rozniak/xfce-winxp-tc) repository.

> [!WARNING]
> This is not a complete nor entirely working flake. Some packages are not added
> yet, and some packages may build erroneously.

## Usage
There is no NixOS module provided (yet). Below, I have provided slightly
abridged excerpts from my personal configuration; I have no idea if these will
work on other machines.

```nix
# For system configuration
{ lib, pkgs, config, inputs', ... }:
let
  wintc = inputs'.xfce-winxp-tc-nixos.packages;
in
{
  fonts.packages = [
    wintc.fonts-xp
  ];

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    displayManager.lightdm = {
      enable = true;
      greeter = {
        enable = true;
        package = pkgs.stdenvNoCC.mkDerivation {
          pname = "wintc-logonui-greeter";
          version = wintc.logonui.version;
          src = "${wintc.logonui}/share/xgreeters";
          installPhase = ''
            mkdir -p $out
            cp -R $src/* $out/
          '';
        };
        name = "wintc-logonui";
      };
    };
    desktopManager.xfce.enable = true;
  };

  services.dbus.packages = [
    wintc.regsvc
  ];

  environment.xfce.excludePackages = with pkgs; [ 
    xfce4-panel
  ];

  environment.systemPackages = [
    # for the greeter
    wintc.icon-theme-luna
    wintc.theme-luna-blue
    wintc.cursor-theme-standard-no-shadow

    # for user usage
    wintc.sound-theme-xp
  ];

  boot = {
    initrd.systemd.enable = true;
    plymouth = {
      enable = true;
      theme = "bootvid";
      themePackages = [
        wintc.bootvid
      ];
    };
    kernelParams = [
      "quiet"
    ];
    loader.timeout = 3;
  };
}
```

On the Home Manager side:
```nix
# For home-manager configuration
{ lib, config, inputs', ... }:
let
  wintc = inputs'.xfce-winxp-tc-nixos.packages;
in
{
  gtk = {
    enable = true;
    iconTheme = {
      name = "luna";
      package = wintc.icon-theme-luna;
    };
    theme = {
      name = "Windows XP style (Blue)";
      package = wintc.theme-luna-blue;
    };
    cursorTheme = {
      name = "standard-no-shadow";
      package =  wintc.cursor-theme-standard-no-shadow;
    };
    font = {
      name = "Tahoma";
      size = 8;
      # Don't need package, as it should be installed globally
    };
  };

  xfconf.settings = {
    xfwm4 = {
      "general/title_alignment" = "left";
      "general/title_font" = "Trebuchet MS Bold 10";
      "general/workspace_count" = 1;
      "general/scroll_workspaces" = false;
      "general/show_dock_shadow" = false;
      "general/show_frame_shadow" = false;
      "general/show_popup_shadow" = false;
    };
    xfce4-notifyd = {
      "notify-location" = "bottom-right";
      "theme" = "XP-Balloon";
    };
    xfce4-keyboard-shortcuts = {
      "commands/default/<Alt>F1" = "${lib.getExe wintc.taskband} --start";
      "commands/default/<Super>r" = "${lib.getExe wintc.shell-run}";
      "commands/custom/<Alt>F1" = "${lib.getExe wintc.taskband} --start";
      "commands/custom/<Super>r" = "${lib.getExe wintc.shell-run}";
    };
    xsettings = {
      "Gtk/ButtonImages" = false;
      "Gtk/MonospaceFontName" = "Monospace 8";
      "Net/SoundThemeName" = "Windows XP Default";
      "Net/EnableEventSounds" = true;
      "Net/EnableInputFeedbackSounds" = true;
      "Xft/Antialias" = 0;
      "Xft/Hinting" = 1;
      "Xft/HintStyle" = "hintfull";
    };
  };

  xdg.configFile."autostart/wintc-taskband.desktop".text = ''
    [Desktop Entry]
    Encoding=UTF-8
    Version=0.9.4
    Type=Application
    Name=wintc-taskband
    Comment=
    Exec=${lib.getExe wintc.taskband}
    OnlyShowIn=XFCE;
    RunHook=0
    StartupNotify=false
    Terminal=false
    Hidden=false
  '';

  services.xcape = {
    enable = true;
    mapExpression = {
      Super_L = "Alt_L|F1";
    };
  };
}
```
