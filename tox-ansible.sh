#!/bin/bash

STDOUT_JSON=false
INCLUDE_CGROUP=auto
WHITELIST_TARGETS=

for arg in "$@"; do
    case "$arg" in
        --stdout)
            STDOUT_JSON=true
            ;;
        --cgroup=v1)
            INCLUDE_CGROUP=v1
            ;;
        --cgroup=v2)
            INCLUDE_CGROUP=v2
            ;;
        --cgroup=auto)
            INCLUDE_CGROUP=auto
            ;;
        --target=*)
            WHITELIST_TARGETS="${arg#*=}"
            ;;
        *)
            echo "unknow: $arg"
            echo "usage: $0 [--stdout] [--cgroup=v1|v2|auto] [--target=<target[,target[,target]]>]"
            exit 1
            ;;
    esac
done

environment__configs=()

while IFS= read -r line; do
    environment__configs+=("$line tox-ansible.ini")
done < <(tox --ansible -c tox-ansible.ini -l 2>/dev/null)
while IFS= read -r line; do
    environment__configs+=("$line tox.ini")
done < <(tox -c tox.ini -l 2>/dev/null)

json_array=()

for environment__config in "${environment__configs[@]}"; do
    IFS=' ' read -r environment conf <<< "$environment__config"
    IFS='-' read -r factor py ansible <<< "$environment"
    python_version=$(echo "$py" | awk -F 'py' '{print $2}')

    skip=$(grep "skip.py.$python_version.ansible.${ansible}" "$conf")
    if [[ -n "$skip" ]]; then
        continue
    fi

    cgroups=()
    if [[ ("$INCLUDE_CGROUP" == "auto" || "$INCLUDE_CGROUP" == "v1") && -z $(grep "skip.ansible.${ansible}.cgroupv1" "$conf") ]]; then
        cgroups+=("cgroupv1")
    elif [[ ("$INCLUDE_CGROUP" == "auto" || "$INCLUDE_CGROUP" == "v2") && -z $(grep "skip.ansible.${ansible}.cgroupv2" "$conf") ]]; then
        cgroups+=("cgroupv2")
    fi

    for cgroup in "${cgroups[@]}"; do
        if [[ "$cgroup" == "cgroupv1" ]]; then
            run_on="ubuntu-20.04"
        else
            run_on="ubuntu-22.04"
        fi
        env_obj="{\"MATCH_MOLECULE_CGROUP\": \"$cgroup\", \"MATCH_MOLECULE_TARGETS\": \"$WHITELIST_TARGETS\"}"
        json_obj="{\"name\": \"ansible$ansible(py$python_version)$factor@$run_on\", \"run_on\": \"$run_on\", \"python_version\": \"$python_version\", \"conf\": \"$conf\", \"environment\": \"$environment\", \"env\": $env_obj, \"factors\": [\"python$python_version\", \"ansible$ansible\"]}"
        json_array+=("$json_obj")
    done
done

if [[ "$STDOUT_JSON" == "true" ]]; then
    # sort by target and ansible
    printf "[%s]\n" "$(IFS=,; echo "${json_array[*]}")" | jq 'sort_by(.name)'
else
    for json_obj in "${json_array[@]}"; do
        conf=$(echo "$json_obj" | jq -r '.conf')
        env=$(echo "$json_obj" | jq -r '.environment')
        cgroup=$(echo "$json_obj" | jq -r '.env.MATCH_MOLECULE_CGROUP')
        targets=$(echo "$json_obj" | jq -r '.env.MATCH_MOLECULE_TARGETS')
        if [[ "$conf" == "tox-ansible.ini" ]]; then
            MATCH_MOLECULE_CGROUP=$cgroup MATCH_MOLECULE_TARGETS=$targets tox --ansible -c "$conf" -e "$env" -v -- -r A
        else
            MATCH_MOLECULE_CGROUP=$cgroup MATCH_MOLECULE_TARGETS=$targets tox -c "$conf" -e "$env" -v
        fi
    done
fi
