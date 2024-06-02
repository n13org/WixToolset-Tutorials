#!/usr/bin/bash

BASEDIR=$(dirname $0)

targetDir="$BASEDIR/data/data"

runtimes=(runtime-aspnetcore runtime-desktop runtime)

outfilenameall="$targetDir/dotnet-all.json"
# echo "" > $outfilenameall

for runtime in ${runtimes[*]}; do
    infilename="$targetDir/dotnet-$runtime.json"
    outfilename="$targetDir/dotnet-$runtime-merged.json"

    jq -r --arg r "$runtime" '.[] |= (. += { "runtime": $r })' $infilename > $outfilename
done

jq -s 'flatten | unique' $targetDir/*-merged.json > $outfilenameall
