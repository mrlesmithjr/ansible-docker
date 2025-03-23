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

environments=()

while IFS= read -r line; do
    environments+=("$line")
done < <(tox -c tox.ini -l 2>/dev/null)

enable_environments=()

for environment in "${environments[@]}"; do
    skip=$(grep "skip.environment.$environment" tox.ini)
    if [[ -n "$skip" ]]; then
        continue
    fi

    IFS='-' read -r ansible scenario <<< "$environment"
    skip=$(grep "skip.scenario.$scenario" tox.ini)
    if [[ -n "$skip" ]]; then
        continue
    fi

    IFS='@' read -r target cgroup <<< "$scenario"
    skip=$(grep "skip.ansible-target.$ansible-$target" tox.ini)
    if [[ -n "$skip" ]]; then
        continue
    fi

    enable_environments+=("$environment")
done

json_array=()

for environment in "${enable_environments[@]}"; do
    IFS='-' read -r ansible scenario <<< "$environment"
    IFS='@' read -r target cgroup <<< "$scenario"

    if [[ "$INCLUDE_CGROUP" == "auto" && "$cgroup" == "cgroupv1" && "${enable_environments[*]}" =~ "$ansible-$target@cgroupv2" ]]; then
        # skip if cgroup v2 exists skip cgroupv1
        continue
    elif [[ "$INCLUDE_CGROUP" == "v1" && "$cgroup" == "cgroupv2" ]]; then
        # skip cgroupv2
        continue
    elif [[ "$INCLUDE_CGROUP" == "v2" && "$cgroup" == "cgroupv1" ]]; then
        # skip cgroupv1
        continue
    fi

    # override run_on
    run_on=$(grep "set.cgroup.$cgroup.run_on" tox.ini | awk -F ' = ' '{print $2}')
    if [[ -z "$run_on" ]]; then
        if [[ "$cgroup" == "cgroupv1" ]]; then
            run_on="ubuntu-20.04"
        else
            run_on="ubuntu-22.04"
        fi
    fi

    # override python_version
    python_version=$(grep "set.ansible.$ansible.python_version" tox.ini | awk -F ' = ' '{print $2}')
    if [[ -z "$python_version" ]]; then
        python_version=$(grep "$ansible: python" tox.ini | awk -F 'python' '{print $2}')
    fi

    json_obj="{\"name\": \"$target-$ansible($cgroup-$python_version)\", \"run_on\": \"$run_on\", \"python_version\": \"$python_version\", \"conf\": \"tox.ini\", \"environment\": \"$environment\", \"factors\": [\"python$python_version\", \"$ansible\", \"$target\", \"$cgroup\"]}"
    json_array+=("$json_obj")
done

if [[ "$STDOUT_JSON" == "true" ]]; then
    # sort by target and ansible
    printf "[%s]\n" "$(IFS=,; echo "${json_array[*]}")" | jq 'sort_by(.name)'
else
    for json_obj in "${json_array[@]}"; do
        conf=$(echo "$json_obj" | jq -r '.conf')
        env=$(echo "$json_obj" | jq -r '.environment')
        tox -c "$conf" -e "$env" -v
    done
fi
