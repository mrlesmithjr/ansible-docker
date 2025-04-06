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

os_name=centos
paths=()
paths+=("7/aarch64")
paths+=("7/armv7l")
paths+=("7/ppc64le")
paths+=("7/x86_64")
paths+=("8/aarch64")
paths+=("8/ppc64le")
paths+=("8/x86_64")
paths+=("9/aarch64")
paths+=("9/ppc64le")
paths+=("9/x86_64")
paths+=("10/aarch64")
paths+=("10/ppc64le")
paths+=("10/x86_64")

for path in "${paths[@]}"; do
    IFS='/' read -r os_version os_arch <<< "$path"

    while IFS= read -r line; do
        if [[ "$line" =~ ^docker-ce-[0-9]+ ]]; then
            package_version="${line#docker-ce-}"
            package_version="${package_version%.rpm}"
            package_version="${package_version%.$os_arch}"
            package_version="${package_version%.$os_version}"

            IFS='-' read -r docker_version p <<< "$package_version"
            docker_version="${docker_version%.ce}"

            json_obj="{\"docker_version\": \"$docker_version\", \"package_version\": \"$package_version\", \"os_name\": \"$os_name\", \"os_version\": \"$os_version\", \"os_arch\": \"$os_arch\"}"
            json_array+=("$json_obj")
        fi
    done < <(curl -s https://download.docker.com/linux/$os_name/$os_version/$os_arch/stable/Packages/ | grep -oP 'href="\K[^"]+' | sort)
done

if [[ "$STDOUT_JSON" == "true" ]]; then
    printf "[%s]\n" "$(IFS=,; echo "${json_array[*]}")" | jq 'sort_by(.name)'
else
    printf "[%s]\n" "$(IFS=,; echo "${json_array[*]}")" | jq 'sort_by(.name)' > $script_path/$script_name_no_ext.json
fi
