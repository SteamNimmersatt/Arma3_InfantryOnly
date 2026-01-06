#!/bin/bash

# Script to build the mod and launch Arma3 with the built mod.

MOD_LIST="z\infonly"
LAUNCH_PARAMETERS="-noLauncher -filePatching -debug -showScriptErrors -skipIntro -noSplash -nopause -world=empty -mod=$MOD_LIST"
HEMTT_PATH="./hemtt"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S.%3N') $1"
}

download_hemtt() {
    if [ ! -f "$HEMTT_PATH" ]; then
        log "Downloading hemtt..."
        wget -O "$HEMTT_PATH" https://github.com/BrettMayson/HEMTT/releases/latest/download/linux-x64
        chmod +x "$HEMTT_PATH"
    fi
}

build_mod() {
    log "------------------Building the mod.------------------"
    "$HEMTT_PATH" dev # This will create a symbolic link at "<arma3 dir>/z/infonly" which allows us to use load the mod from this directory.
}

launch_arma() {
    log "------------------Launching Arma.------------------"
    steam -applaunch 107410 $LAUNCH_PARAMETERS &
}

download_hemtt
build_mod
launch_arma
