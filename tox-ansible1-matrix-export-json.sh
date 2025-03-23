#!/bin/bash

lines=()

while IFS= read -r line; do
    lines+=("$line")
done < <(tox -c tox.ini -l 2>/dev/null)

json_array=()

for line in "${lines[@]}"; do
    IFS='-' read -r ansible target <<< "$line"
    if [[ "$line" != *"lint_all"* && "$line" != "python" && "$target" != "python" ]]; then
        IFS='@' read -r target cgroup <<< "$target"
        # skip if cgroup v2 exists
        if [[ "$cgroup" == "cgroupv1" && " ${lines[*]} " =~ " $ansible-$target@cgroupv2 " ]]; then
            continue
        fi
        if [[ "$cgroup" == "cgroupv1" ]]; then
            run_on="ubuntu-20.04"
        else
            run_on="ubuntu-22.04"
        fi
        python_version=$(cat tox.ini | grep "$ansible: python" | awk -F 'python' '{print $2}')
        json_obj="{\"name\": \"$line\", \"run_on\": \"$run_on\", \"python_version\": \"$python_version\", \"conf\": \"tox.ini\", \"factors\": [\"python$python_version\", \"$ansible\", \"$target\", \"$cgroup\"]}"
        json_array+=("$json_obj")
    fi
done

printf "[%s]\n" "$(IFS=,; echo "${json_array[*]}")" | jq .
