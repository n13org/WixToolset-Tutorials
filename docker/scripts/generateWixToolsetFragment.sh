#!/usr/bin/bash

BASEDIR=$(dirname $0)
. "$BASEDIR/_variables.sh"

targetDir="$BASEDIR/data/wix-dotnet"
mkdir -p "$targetDir"

for runtime in ${runtimes[*]}; do
    case $runtime in
    runtime-aspnetcore)
        runtimetype="aspnet"
        runtimename="ASP.NET Core"
        runtimeid="ASP_NET"
        ;;
    runtime-desktop)
        runtimetype="desktop"
        runtimename="Desktop Runtime"
        runtimeid="DesktopRuntime"
        ;;
    runtime)
        runtimetype="core"
        runtimename="Runtime"
        runtimeid="Runtime"
        ;;
    esac

    sourcefilename="$BASEDIR/data/data/dotnet-$runtime.json"
    echo "Parse JSON-Data $sourcefilename ..."

    items=$(cat "$sourcefilename" | jq -c -r '.[]')

    for item in ${items[@]}; do
        echo "Parse $item ..."

        platform=$((echo $item) | jq -r '.platform')
        version=$((echo $item) | jq -r '.version')
        os=$((echo $item) | jq -r '.os')
        link=$((echo $item) | jq -r '.link')
        hash=$((echo $item) | jq -r '.hash')
        bytes=$((echo $item) | jq -r '.bytes')

        if [[ $os == *"macos"* ]]; then
            echo "MacOS is not supported, entry will be skiped"
            continue
        fi

        major=$((echo $version) | grep -Eo '^[0-9]+')
        major_minor=$((echo $version) | grep -Eo '^[0-9]+.[0-9]+')
        version_encoded=$((echo $version) | sed 's#[.]#_#g')

        # echo $major
        # echo $major_minor
        # echo $version_encoded

        template=$(
        cat << HEREDOC
<Wix xmlns="http://wixtoolset.org/schemas/v4/wxs"
     xmlns:netfx="http://wixtoolset.org/schemas/v4/wxs/netfx"
     xmlns:bal="http://wixtoolset.org/schemas/v4/wxs/bal">

    <Fragment>
    <netfx:DotNetCoreSearch
        RuntimeType="${runtimetype}"
        Platform="${platform}"
        MajorVersion="${major}"
        Variable="DOT_NET_VER" />

    <PackageGroup Id="DotNet_${runtimeid}_v${version_encoded}_${platform}">
    <ExePackage Id="Netfx${major}0"
                DisplayName="Microsoft .NET ${major_minor} ${runtimename}"
                Description="Microsoft .NET ${major_minor} (${version}) ${runtimename} for ${os} ${platform}"
                PerMachine="yes" Permanent="yes" Vital="yes" InstallArguments="/norestart /quiet"
                DetectCondition="DOT_NET_VER &gt;= v${version}"
                bal:PrereqPackage="yes">
        <ExePackagePayload
            Name="${runtime}-${version}-${os}-${platform}.exe"
            DownloadUrl="${link}"
            Hash="${hash}"
            Size="${bytes}" />
        <ExitCode Value="0" Behavior="success" />
        <ExitCode Behavior="scheduleReboot" />
    </ExePackage>
    </PackageGroup>
    </Fragment>
</Wix>
HEREDOC
)

        targetfile="$targetDir/DotNet_${runtimeid}_v${version}_${platform}.wxs"
        echo "$template" > "$targetfile"
        echo "$targetfile written sucessfully."
    done
    echo "... done"

done
