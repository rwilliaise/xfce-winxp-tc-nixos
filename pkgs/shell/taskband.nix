{
  lib,
  stdenv,
  xfce-winxp-tc-repo,

  autoPatchelfHook,
  cmake,
  pkg-config,
  ninja,

  libcanberra,
  libcanberra-gtk3,
  libxfce4ui,
  garcon,
  gdk-pixbuf,
  glib,
  gtk3,
  upower,
  networkmanager,
  libwnck,

  comctl,
  comgtk,
  exec,
  shcommon,
  shelldpa,
  shellext,
  shlang,
  sndapi,

  _defaultCmakeFlags,

  sku ? "xpclient-pro",
}:

stdenv.mkDerivation {
  pname = "wintc-taskband";
  version = xfce-winxp-tc-repo.rev;
  src = xfce-winxp-tc-repo;

  nativeBuildInputs = [
    autoPatchelfHook
    cmake
    pkg-config
    ninja
  ];
  buildInputs = [
    libcanberra
    libcanberra-gtk3
    libxfce4ui
    garcon
    gdk-pixbuf
    glib
    gtk3
    upower.dev
    networkmanager.dev

    comctl
    comgtk
    exec
    shcommon
    shelldpa
    shellext
    shlang
    sndapi
  ];

  runtimeDependencies = [
    libwnck
  ];

  preConfigure = "cd shell/taskband";

  cmakeFlags = _defaultCmakeFlags ++ [
    (lib.strings.cmakeFeature "WINTC_SKU" sku)
  ];
}
