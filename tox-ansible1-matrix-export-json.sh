#!/bin/bash

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

    # skip if cgroup v2 exists skip cgroupv1
    if [[ "$cgroup" == "cgroupv1" && "${enable_environments[*]}" =~ "$ansible-$target@cgroupv2" ]]; then
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
# sort by target and ansible
printf "[%s]\n" "$(IFS=,; echo "${json_array[*]}")" | jq 'sort_by(.name)'
