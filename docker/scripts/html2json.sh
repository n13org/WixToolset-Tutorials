#!/usr/bin/bash

BASEDIR=$(dirname $0)
. "$BASEDIR/_variables.sh"

targetDir="$BASEDIR/data/data"
mkdir -p "$targetDir"

for runtime in ${runtimes[*]}; do
    outfilename="$targetDir/dotnet-$runtime.json"

    json="[]"

    filenames=`ls $BASEDIR/data/download/*.html | grep -E "$runtime-[0-9]+"`

    for filename in ${filenames[*]}; do
        echo "Parse $filename ..."

        title=$(grep 'property="og:title"' $filename | grep -Eo 'content="(.*)"')
        #echo $title
        if [[ $title == *"404"* ]]; then
            echo "404 in the title, file will be skiped"
            continue
        fi

        version=$(echo $filename | grep -Eo '[0-9]+.[0-9]+.[0-9]+')
        #echo $version

        platform=$(echo $filename | grep -Eo '(arm64|x86|x64)')
        #echo $platform

        os=$(echo $filename | grep -Eo '(windows|macos)')
        #echo $os

        link=$(grep 'id="directLink"' $filename | grep -Eo 'href="(\S*)"' | sed 's#href="##g' | sed 's#"##g')
        #echo $link

        hash=$(grep 'id="checksum"' $filename | grep -Eo 'value="(\S*)"' | sed 's#value="##g' | sed 's#"##g')
        #echo $hash

        bytes=$(curl -sI "$link" | grep -i "content-length" | sed 's#content-length: ##g' | sed 's#\r##g')
        #echo $bytes

        obj=$(jq -n \
            --arg v "$version" \
            --arg p "$platform" \
            --arg o "$os" \
            --arg l "$link" \
            --arg h "$hash" \
            --arg s "$bytes" \
            '{ version: $v, platform: $p, os: $o, link: $l, hash: $h, bytes: $s }')
        # echo $obj
        json=$((echo $json) | jq ". += [$obj]")
    done

    (echo $json | jq -r) > $outfilename
    echo "$outfilename written sucessfully."
done
