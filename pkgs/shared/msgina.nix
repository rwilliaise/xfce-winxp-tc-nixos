{
  lib,
  stdenv,
  xfce-winxp-tc-repo,

  cmake,
  pkg-config,
  ninja,

  gdk-pixbuf,
  glib,
  gtk3,
  lightdm,

  comctl,
  comgtk,
  winbrand,

  _defaultCmakeFlags,

  sku ? "xpclient-pro",
}:

stdenv.mkDerivation {
  pname = "wintc-msgina";
  version = xfce-winxp-tc-repo.rev;
  src = xfce-winxp-tc-repo;

  nativeBuildInputs = [
    cmake
    pkg-config
    ninja
  ];
  buildInputs = [
    gdk-pixbuf
    glib
    gtk3
    lightdm.dev

    comctl
    comgtk
    winbrand
  ];

  preConfigure = "cd shared/msgina";

  cmakeFlags = _defaultCmakeFlags ++ [
    (lib.strings.cmakeFeature "WINTC_SKU" sku)
  ];
}
