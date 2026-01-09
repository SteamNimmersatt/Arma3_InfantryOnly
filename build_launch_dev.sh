#!/bin/bash
# Script to build the mod and launch Arma3.

##################################################################
# Hot Code Replace (edit scripts while Arma3 is running)
#
# - Enable "DISABLE_COMPILE_CACHE" in file "script_component.hpp".
# - Only works for scripts that have "recompile = 1" set.
# - Reload the map / restart to reload the code.

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

run_hemmt() {
    log "------------------Running 'hemtt launch'------------------"
    "$HEMTT_PATH" launch # This will build a 'dev' version and launch Arma3 using the parameters defined in '/.hemmt/launch.toml.
}


MOD_LIST="z\infonly"
LAUNCH_PARAMETERS="-noLauncher -filePatching -debug -showScriptErrors -skipIntro -noSplash -nopause -world=empty -mod=$MOD_LIST"
HEMTT_PATH="./hemtt"

download_hemtt
run_hemmt
