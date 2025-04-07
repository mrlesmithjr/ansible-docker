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

paths=()

pkgs=()
pkgs+=("ContainerManager")
pkgs+=("Docker")

for pkg in "${pkgs[@]}"; do
    while IFS= read -r line; do
        if [[ "$line" =~ \/$pkg\/ ]]; then
            paths+=("https://archive.synology.com$line")
        fi
    done < <(curl -s https://archive.synology.com/download/Package/$pkg/ | grep -oP 'href="\K[^"]+' | sort)
done


json_array=()

os_name=dsm
for path in "${paths[@]}"; do
    while IFS= read -r line; do
        if [[ "$line" =~ \.spk$ ]]; then
            IFS='/' read -ra parts <<< "$line"
            pkg_name="${parts[-3]}"
            pkg_ver="${parts[-2]}"
            pkg_spk="${parts[-1]}"

            docker_version="${pkg_ver}"
            package_version="${pkg_spk%.spk}"
            os_version="NA"
            tmp="${pkg_spk#${pkg_name}-}"
            tmp="${tmp%.spk}"
            os_arch="${tmp%-${pkg_ver}}"

            json_obj="{\"docker_version\": \"$docker_version\", \"package_version\": \"$package_version\", \"os_name\": \"$os_name\", \"os_version\": \"$os_version\", \"os_arch\": \"$os_arch\"}"
            json_array+=("$json_obj")
        fi
    done < <(curl -s "$path" | grep -oP 'href="\K[^"]+' | sort)
done

if [[ "$STDOUT_JSON" == "true" ]]; then
    printf "[%s]\n" "$(IFS=,; echo "${json_array[*]}")" | jq 'sort_by(.name)'
else
    printf "[%s]\n" "$(IFS=,; echo "${json_array[*]}")" | jq 'sort_by(.name)' > $script_path/$script_name_no_ext.json
fi
