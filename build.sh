#!/bin/bash

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
    log "------------------Running 'hemtt dev'------------------"
    "$HEMTT_PATH" dev # This will create a symbolic link at "<arma3 dir>/z/infonly" which allows us to use load the mod from this directory.
}

HEMTT_PATH="./hemtt"

download_hemtt
build_mod