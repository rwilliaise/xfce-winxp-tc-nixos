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
  msgina,

  _defaultCmakeFlags,

  sku ? "xpclient-pro",
}:

stdenv.mkDerivation {
  pname = "wintc-logonui";
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
    msgina
  ];

  preConfigure = "cd base/logonui";

  postInstall = ''
    substituteInPlace $out/share/xgreeters/wintc-logonui.desktop \
      --replace-fail "Exec=logonui" "Exec=$out/bin/logonui"
  '';

  cmakeFlags = _defaultCmakeFlags ++ [
    (lib.strings.cmakeFeature "WINTC_SKU" sku)
  ];
}
