#!/usr/bin/bash

oss=(windows macos)
platforms=(arm64 x64 x86)
runtimes=(runtime-aspnetcore runtime-desktop runtime)

declare -A arr_versions
arr_versions["5"]="5.0.17"
arr_versions["6"]="6.0.31"
arr_versions["7"]="7.0.20"
arr_versions["8"]="8.0.6"
