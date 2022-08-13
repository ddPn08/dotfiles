#!/bin/bash

export MSYS=winsymlinks:nativestrict

DIRCTORY="$( dirname -- "$0" )"

case $(uname) in
    Linux)
        PLATFORM="LINUX"
        ;;
    Darwin)
        PLATFORM="OSX"
        ;;
    MINGW*)
        PLATFORM="MINGW"
        ;;
    *)
        echo "Unknown platform"
        exit 1
        ;;
esac

CONFIG_LINK=($(ls .config))

for value in "${CONFIG_LINK[@]}"; do
    if [ ! -d "$HOME/.config" ]; then
        mkdir "$HOME/.config"
    fi
    config_target="$DIRCTORY/.config/$value"
    config_path="$HOME/.config/$value"
    if [ -d $path ]; then
        rm -Rf $config_path
    fi
    ln -s $config_target $config_path
done

if [ $PLATFORM = "MINGW" ]; then
    rm -f /usr/etc/fish/config.fish
    if [ ! -d /usr/etc/fish ]; then
        mkdir -p /usr/etc/fish
    fi
    ln $DIRCTORY/fish/config.fish /usr/etc/fish/config.fish
fi
