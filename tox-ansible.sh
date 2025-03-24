#!/bin/bash

STDOUT_JSON=false
INCLUDE_CGROUP=auto

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
        *)
            echo "unknow: $arg"
            echo "usage: $0 [--stdout] [--cgroup=v1|v2|auto]"
            exit 1
            ;;
    esac
done

enable_environments=()

while IFS= read -r line; do
    enable_environments+=("$line")
done < <(tox --ansible -c tox-ansible.ini -l 2>/dev/null)

json_array=()

for environment in "${enable_environments[@]}"; do
    IFS='-' read -r factor py ansible <<< "$environment"
    python_version=$(echo "$py" | awk -F 'py' '{print $2}')
    cgroups=()
    if [[ "$INCLUDE_CGROUP" == "auto" ]]; then
        cgroups+=("cgroupv1")
        cgroups+=("cgroupv2")
    elif [[ "$INCLUDE_CGROUP" == "v1" ]]; then
        cgroups+=("cgroupv1")
    elif [[ "$INCLUDE_CGROUP" == "v2" ]]; then
        cgroups+=("cgroupv2")
    fi

    for cgroup in "${cgroups[@]}"; do
        if [[ "$cgroup" == "cgroupv1" ]]; then
            run_on="ubuntu-20.04"
        else
            run_on="ubuntu-22.04"
        fi
        json_obj="{\"name\": \"ansible$ansible(py$python_version)@$run_on\", \"cgroup\": \"$cgroup\", \"run_on\": \"$run_on\", \"python_version\": \"$python_version\", \"conf\": \"tox-ansible.ini\", \"environment\": \"$environment\", \"factors\": [\"python$python_version\", \"ansible$ansible\"]}"
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
        cgroup=$(echo "$json_obj" | jq -r '.cgroup')
        MATCH_MOLECULE_CGROUP=$cgroup tox --ansible -c "$conf" -e "$env" -v
    done
fi
