#!/bin/bash

# Use at your own risk :P

local copy_pasta_folder="/tmp/copy-pasta"

copy() {
    # Exit on missing vars or failure for safety
    set -u
    set -e
    set -x

    if [ $# -lt 1 ]; then
        cat << EOF
usage: copy <files and directories to copy>
EOF
    return 1
    fi

    if [ -d "$copy_pasta_folder" ]; then
        rm -rf "${copy_pasta_folder:?}"/{*,.*}
    else
        mkdir "$copy_pasta_folder"
    fi

    cp -r "$@" "$copy_pasta_folder"

}

pasta() {
    # Exit on missing vars or failure for safety
    set -u
    set -e
    set -x
    if [ $# -gt 1 ]; then
        cat >&2 << EOF
Usage:
  pasta [destination dir]

If destination dir is omitted the current directory is used.
EOF
        return 1
    elif [ $# == 0 ]; then
        local dest="."
    else
        local dest="$1"
    fi

    if [ ! -d "$copy_pasta_folder" ]; then
        cat >&2 << EOF
Remember to copy before you pasta!
EOF
        return 1
    fi

    cp -r "$copy_pasta_folder"/{*,.*} "$dest"
}
