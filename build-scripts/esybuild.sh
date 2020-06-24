#!/bin/bash

# =====================================
# Globals
# =====================================

# shellcheck disable=SC2154
readonly INSTALL_PREFIX=$cur__install
readonly SOURCE_PATH=$(pwd)
readonly BUILD_PATH="${SOURCE_PATH}/esy_build"

# =====================================
# Utils
# =====================================

# SDL2 build instructions specifies that we should use
# a separate build directory instead of building in the
# base of the source tree.
# see: https://wiki.libsdl.org/Installation
execute_inside_build_dir() {
  [ ! -d "$BUILD_PATH" ] && mkdir "$BUILD_PATH"

  (cd "$BUILD_PATH" && "$@")
}

make_and_install() {
  make -j4 && make install
}

# =====================================
# Setup functions
# =====================================

setup_macos() {
  "${SOURCE_PATH}"/configure \
    --enable-shared=no \
    --enable-static=yes \
    --disable-video-x11 \
    --prefix="$INSTALL_PREFIX"
}

setup_windows() {
  SHELL=bash CC=x86_64-w64-mingw32-gcc WINDRES=x86_64-w64-mingw32-windres SDL_THREAD_PTHREAD=1 "${SOURCE_PATH}"/configure \
    --prefix="$INSTALL_PREFIX" \
    --enable-pthreads
}

setup_linux() {
  CONFIG_SHELL=bash CFLAGS="-fPIC -fcommon" "${SOURCE_PATH}"/configure --prefix="$INSTALL_PREFIX"
}

while [ "$1" != "" ]; do
  case $1 in
    --os=darwin)
      execute_inside_build_dir setup_macos
      break
      ;;
    --os=linux)
      execute_inside_build_dir setup_linux
      break
      ;;
    --os=windows)
      execute_inside_build_dir setup_windows
      break
      ;;
    *)
      break
      ;;
  esac
done

execute_inside_build_dir make_and_install
