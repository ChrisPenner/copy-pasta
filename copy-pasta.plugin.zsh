#!/bin/bash

# Use at your own risk :P

local copy_pasta_folder="/tmp/copy-pasta"

# Operates in a subshell so we can exit on errors for safety
copy() {(
    # Exit on missing vars or failure for safety
    set -u
    set -e
    # Don't print errors on glob fail
    setopt +o nomatch

    if [ $# -lt 1 ]; then
        cat << EOF
usage: copy <files and directories to copy>
EOF
    return 1
    fi

    if [ -d "$copy_pasta_folder" ]; then
        rm -rf "${copy_pasta_folder:?}"/{*,.*} 2>/dev/null || true
    else
        mkdir "$copy_pasta_folder"
    fi

    cp -r "$@" "$copy_pasta_folder"

)}

# Operates in a subshell so we can exit on errors for safety
pasta() {(
    # Exit on missing vars or failure for safety
    set -u
    set -e
    # Don't print errors on glob fail
    setopt +o nomatch

    if [ $# -gt 1 ]; then
        cat >&2 << EOF
Usage:
  pasta [destination dir]

If destination dir is omitted the current directory is used.
EOF
        return 1
    elif [ $# -eq 0 ]; then
        local dest="."
    else
        local dest="$1"
        if ! [ -d "$dest" ] ; then
            echo "Creating $dest directory" >&2;
            mkdir -p "$dest"
        fi
    fi

    if [ ! -d "$copy_pasta_folder" ]; then
        cat >&2 << EOF
Remember to copy before you pasta!
EOF
        return 1
    fi

    cp -r "$copy_pasta_folder"/{*,.*} "$dest" 2> /dev/null || true
)}
