#!/usr/bin/bash

BASEDIR=$(dirname $0)

. "$BASEDIR/_variables.sh"

targetDir="$BASEDIR/data/download"
mkdir -p "$targetDir"

for os in ${oss[*]}; do
    echo "OS: $os"
    for platform in ${platforms[*]}; do
        echo "Platform: $platform"
        for key in "${!arr_versions[@]}"; do
            echo "Range $key.0.0 -> ${arr_versions[$key]}"
            max=$((echo ${arr_versions[$key]}) | grep -Eo '[0-9]+$')
            for patch in $(seq 0 $max); do
                for runtime in ${runtimes[*]}; do
                    filename="$runtime-$key.0.$patch-$os-$platform-installer"
                    if [ ! -f "$targetDir/$filename.html" ]; then
                        echo "Download $filename ..."
                        curl -o "$targetDir/$filename.html" "https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/$filename"
                    fi
                done
            done
        done
    done
done
