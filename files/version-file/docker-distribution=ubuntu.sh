#!/bin/bash

script_path=$(dirname "$(realpath "$0")")
script_name=$(basename "$0")
script_name_no_ext="${script_name%.*}"

STDOUT_JSON=false

for arg in "$@"; do
    case "$arg" in
        --stdout)
            STDOUT_JSON=true
            ;;
        *)
            echo "unknow: $arg"
            echo "usage: $0 [--stdout]"
            exit 1
            ;;
    esac
done

json_array=()

os_name=ubuntu
paths=()
paths+=("trusty/14.04/amd64")
paths+=("trusty/14.04/armhf")
paths+=("xenial/16.04/amd64")
paths+=("xenial/16.04/arm64")
paths+=("xenial/16.04/armhf")
paths+=("xenial/16.04/pc64el")
paths+=("xenial/16.04/s390x")
paths+=("yakkety/16.10/amd64")
paths+=("yakkety/16.10/armhf")
paths+=("yakkety/16.10/s390x")
paths+=("zesty/17.04/amd64")
paths+=("zesty/17.04/arm64")
paths+=("zesty/17.04/armhf")
paths+=("zesty/17.04/pc64el")
paths+=("zesty/17.04/s390x")
paths+=("artful/17.10/amd64")
paths+=("artful/17.10/armhf")
paths+=("artful/17.10/pc64el")
paths+=("artful/17.10/s390x")
paths+=("bionic/18.04/amd64")
paths+=("bionic/18.04/arm64")
paths+=("bionic/18.04/armhf")
paths+=("bionic/18.04/pc64el")
paths+=("bionic/18.04/s390x")
paths+=("cosmic/18.10/amd64")
paths+=("cosmic/18.10/arm64")
paths+=("cosmic/18.10/armhf")
paths+=("disco/19.04/amd64")
paths+=("disco/19.04/arm64")
paths+=("disco/19.04/armhf")
paths+=("eoan/19.10/amd64")
paths+=("eoan/19.10/arm64")
paths+=("eoan/19.10/armhf")
paths+=("focal/20.04/amd64")
paths+=("focal/20.04/arm64")
paths+=("focal/20.04/armhf")
paths+=("focal/20.04/pc64el")
paths+=("focal/20.04/s390x")
paths+=("groovy/20.10/amd64")
paths+=("groovy/20.10/arm64")
paths+=("groovy/20.10/pc64el")
paths+=("groovy/20.10/s390x")
paths+=("hirsute/21.04/amd64")
paths+=("hirsute/21.04/arm64")
paths+=("hirsute/21.04/armhf")
paths+=("hirsute/21.04/pc64el")
paths+=("hirsute/21.04/s390x")
paths+=("impish/21.10/amd64")
paths+=("impish/21.10/arm64")
paths+=("impish/21.10/armhf")
paths+=("impish/21.10/pc64el")
paths+=("impish/21.10/s390x")
paths+=("jammy/22.04/amd64")
paths+=("jammy/22.04/arm64")
paths+=("jammy/22.04/armhf")
paths+=("jammy/22.04/pc64el")
paths+=("jammy/22.04/s390x")
paths+=("kinetic/22.10/amd64")
paths+=("kinetic/22.10/arm64")
paths+=("kinetic/22.10/armhf")
paths+=("kinetic/22.10/pc64el")
paths+=("kinetic/22.10/s390x")
paths+=("lunar/23.04/amd64")
paths+=("lunar/23.04/arm64")
paths+=("lunar/23.04/armhf")
paths+=("lunar/23.04/pc64el")
paths+=("lunar/23.04/s390x")
paths+=("mantic/23.10/amd64")
paths+=("mantic/23.10/arm64")
paths+=("mantic/23.10/armhf")
paths+=("mantic/23.10/pc64el")
paths+=("mantic/23.10/s390x")
paths+=("noble/24.04/amd64")
paths+=("noble/24.04/arm64")
paths+=("noble/24.04/armhf")
paths+=("noble/24.04/pc64el")
paths+=("noble/24.04/s390x")
paths+=("oracular/24.10/amd64")
paths+=("oracular/24.10/arm64")
paths+=("oracular/24.10/armhf")
paths+=("oracular/24.10/pc64el")
paths+=("oracular/24.10/s390x")
paths+=("plucky/25.04/amd64")
paths+=("plucky/25.04/arm64")
paths+=("plucky/25.04/armhf")


for path in "${paths[@]}"; do
    IFS='/' read -r os_version os_version2 os_arch <<< "$path"

    while read -r package_version; do
        if [[ "$package_version" == *:* ]]; then
            epoch="${package_version%%:*}"
            upstream_version="${package_version#*:}"
        else
            epoch="0"
            upstream_version="$package_version"
        fi

        docker_version="${upstream_version%%~*}"
        docker_version="${docker_version%%-*}"

        json_obj="{\"docker_version\": \"$docker_version\", \"package_version\": \"$package_version\", \"os_name\": \"$os_name\", \"os_version\": \"$os_version\", \"os_arch\": \"$os_arch\"}"
        json_array+=("$json_obj")
    done < <(curl -s "https://download.docker.com/linux/$os_name/dists/$os_version/stable/binary-$os_arch/Packages" | awk '
        $1 == "Package:" && $2 == "docker-ce" { in_block = 1; next }
        $1 == "Package:" { in_block = 0 }
        in_block && $1 == "Version:" { print $2 }
    ')
done

if [[ "$STDOUT_JSON" == "true" ]]; then
    printf "[%s]\n" "$(IFS=,; echo "${json_array[*]}")" | jq 'sort_by(.name)'
else
    printf "[%s]\n" "$(IFS=,; echo "${json_array[*]}")" | jq 'sort_by(.name)' > $script_path/$script_name_no_ext.json
fi
