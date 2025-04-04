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

os_name=debian
paths=()
paths+=("bookworm/debian.12/amd64")
paths+=("bookworm/debian.12/arm64")
paths+=("bookworm/debian.12/armhf")
paths+=("bookworm/debian.12/ppc64el")
paths+=("bookworm/debian.12/s390x")
paths+=("bullseye/debian.11/amd64")
paths+=("bullseye/debian.11/arm64")
paths+=("bullseye/debian.11/armhf")
paths+=("bullseye/debian.11/ppc64el")
paths+=("buster/debian-buster/amd64")
paths+=("buster/debian-buster/arm64")
paths+=("buster/debian-buster/armhf")
paths+=("buster/debian-buster/ppc64el")
paths+=("jessie/debian-jessie/amd64")
paths+=("jessie/debian-jessie/arm64")
paths+=("jessie/debian-jessie/armhf")
paths+=("stretch/debian-stretch/amd64")
paths+=("stretch/debian-stretch/arm64")
paths+=("stretch/debian-stretch/armhf")
paths+=("wheezy/debian-wheezy/amd64")
paths+=("wheezy/debian-wheezy/armhf")

for path in "${paths[@]}"; do
    IFS='/' read -r os_version os_version2 os_arch <<< "$path"

    while IFS= read -r line; do
        if [[ "$line" =~ ^docker-ce_[0-9]+ ]]; then
            package_version="${line#docker-ce_}"
            package_version="${package_version%.deb}"
            package_version="${package_version%_$os_arch}"
            # package_version="${package_version%~$os_version}"
            # package_version="${package_version%~$os_version2}"

            IFS='-' read -r docker_version p <<< "$package_version"
            IFS='~' read -r docker_version p <<< "$docker_version"
            docker_version="${docker_version%.ce}"

            json_obj="{\"docker_version\": \"$docker_version\", \"package_version\": \"$package_version\", \"os_name\": \"$os_name\", \"os_version\": \"$os_version\", \"os_arch\": \"$os_arch\"}"
            json_array+=("$json_obj")
        fi
    done < <(curl -s https://download.docker.com/linux/$os_name/dists/$os_version/pool/stable/$os_arch/ | grep -oP 'href="\K[^"]+' | sort)
done

if [[ "$STDOUT_JSON" == "true" ]]; then
    printf "[%s]\n" "$(IFS=,; echo "${json_array[*]}")" | jq 'sort_by(.name)'
else
    printf "[%s]\n" "$(IFS=,; echo "${json_array[*]}")" | jq 'sort_by(.name)' > $script_path/$script_name_no_ext.json
fi
