{
  lib,
  stdenv,
  xfce-winxp-tc-repo,

  cmake,
  pkg-config,
  ninja,

  _defaultCmakeFlags,

  libcanberra,
  libcanberra-gtk3,
  glib,
  gtk3,

  sku ? "xpclient-pro",
}:

stdenv.mkDerivation {
  pname = "wintc-comgtk";
  version = xfce-winxp-tc-repo.rev;
  src = xfce-winxp-tc-repo;
  
  nativeBuildInputs = [
    cmake
    pkg-config
    ninja
  ];

  buildInputs = [
    libcanberra
    libcanberra-gtk3
    glib
    gtk3
  ];

  preConfigure = "cd shared/comgtk";

  cmakeFlags = _defaultCmakeFlags ++ [
    (lib.strings.cmakeFeature "WINTC_SKU" sku)
  ];
}
