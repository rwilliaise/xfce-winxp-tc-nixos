{
  description = "WinXP TC for NixOS";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } ({ ... }: {
      systems = [ 
        "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" 
      ];

      perSystem = { pkgs, ... }: {
        packages = pkgs.lib.filterAttrs (_: pkgs.lib.isDerivation) (
          pkgs.lib.makeScope pkgs.newScope (self: {
            _defaultCmakeFlags = with pkgs.lib.strings; [
              (cmakeBool "BUILD_SHARED_LIBS" true)
              (cmakeBool "WINTC_USE_LOCAL_LIBS" false)
              (cmakeFeature "WINTC_PKGMGR" "raw")
              (cmakeFeature "WINTC_PKGMGR_EXT" "std")
            ];

            xfce-winxp-tc-repo = pkgs.fetchFromGitHub {
              owner = "rozniak";
              repo = "xfce-winxp-tc";
              rev = "ce7c86985cce4c9ab18a44b40a8cd512c79dfcaa";
              hash = "sha256-QNiKUjJAum8zAfnn8xtW+yqspLlOWsCeEv1xMkbtKLI=";
            };

            # base/
            bldtag = self.callPackage ./pkgs/base/bldtag.nix {};
            bootvid = self.callPackage ./pkgs/base/bootvid.nix {};
            logonui = self.callPackage ./pkgs/base/logonui.nix {};
            regsvc = self.callPackage ./pkgs/base/regsvc.nix {};
            smss = self.callPackage ./pkgs/base/smss.nix {};

            # cursors/
            cursor-theme-standard-no-shadow = self.callPackage
              ./pkgs/cursors/no-shadow/standard.nix {};
            cursor-theme-standard-with-shadow = self.callPackage
              ./pkgs/cursors/with-shadow/standard.nix {};

            # enduser/
            user-pictures = self.callPackage ./pkgs/enduser/userpics.nix {};

            # fonts/
            fonts-xp = self.callPackage ./pkgs/fonts.nix {};

            # icons/
            icon-theme-luna = self.callPackage ./pkgs/icons/luna.nix {};

            # shared/
            comctl = self.callPackage ./pkgs/shared/comctl.nix {};
            comgtk = self.callPackage ./pkgs/shared/comgtk.nix {};
            exec = self.callPackage ./pkgs/shared/exec.nix {};
            msgina = self.callPackage ./pkgs/shared/msgina.nix {};
            registry = self.callPackage ./pkgs/shared/registry.nix {};
            shcommon = self.callPackage ./pkgs/shared/shcommon.nix {};
            shell = self.callPackage ./pkgs/shared/shell.nix {};
            shelldpa = self.callPackage ./pkgs/shared/shelldpa.nix {};
            shellext = self.callPackage ./pkgs/shared/shellext.nix {};
            shlang = self.callPackage ./pkgs/shared/shlang.nix {};
            sndapi = self.callPackage ./pkgs/shared/sndapi.nix {};
            winbrand = self.callPackage ./pkgs/shared/winbrand.nix {};
            
            # shell/
            exitwin = self.callPackage ./pkgs/shell/exitwin.nix {};
            shell-run = self.callPackage ./pkgs/shell/run.nix {};
            taskband = self.callPackage ./pkgs/shell/taskband.nix {};

            # sounds/
            sound-theme-xp = self.callPackage ./pkgs/sounds.nix {};

            # themes/
            theme-luna-blue = self.callPackage ./pkgs/themes/luna/blue.nix {};

            # wallpapers/
            wallpapers = self.callPackage ./pkgs/wallpapers.nix {};
          })
        );
      };
    });
}
