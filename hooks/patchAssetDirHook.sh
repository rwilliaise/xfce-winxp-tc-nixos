
patchAssetDirPreConfigure() {
    export -f substituteInPlace
    export -f substitute
    export -f consumeEntire
    export -f substituteStream
    export out
    find . -name "*.c" -exec bash -c 'substituteInPlace "$0" --replace-quiet "WINTC_ASSETS_DIR" "\"$out/share/wintc\""' {} \;
    find . -name "*.h" -exec bash -c 'substituteInPlace "$0" --replace-quiet "WINTC_ASSETS_DIR" "\"$out/share/wintc\""' {} \;
}

preConfigureHooks+=(patchAssetDirPreConfigure)
