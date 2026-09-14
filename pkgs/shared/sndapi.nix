{
  lib,
  stdenv,
  xfce-winxp-tc-repo,

  cmake,
  pkg-config,
  ninja,

  glib,
  gtk3,
  libpulseaudio,

  comgtk,

  _defaultCmakeFlags,

  sku ? "xpclient-pro",
}:

stdenv.mkDerivation {
  pname = "wintc-sndapi";
  version = xfce-winxp-tc-repo.rev;
  src = xfce-winxp-tc-repo;

  nativeBuildInputs = [
    cmake
    pkg-config
    ninja
  ];
  buildInputs = [
    glib
    gtk3
    libpulseaudio

    comgtk
  ];

  preConfigure = "cd shared/sndapi";

  cmakeFlags = _defaultCmakeFlags ++ [
    (lib.strings.cmakeFeature "WINTC_SKU" sku)
  ];
}
