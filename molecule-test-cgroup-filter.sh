#!/bin/bash

get_current_cgroup_version() {
    if [[ -f /sys/fs/cgroup/cgroup.controllers ]]; then
        echo "cgroupv2"
    else
        echo "cgroupv1"
    fi
}

ansible=$(ansible --version | grep -oP 'ansible (\[core )?\K[0-9]+\.[0-9]+')

scenarios=()
while IFS= read -r line; do
    if [[ -n "$line" && "$line" != *"Scenario Name"* ]]; then
        scenarios+=("$line")
    fi
done < <(molecule list 2>/dev/null | awk -F '│' '{print $4}' | sed 's/^ *//;s/ *$//' | tail -n +2)

for scenario in "${scenarios[@]}"; do
    IFS='@' read -r target cgroup <<< "$scenario"

    MATCH_MOLECULE_TARGETS=${MATCH_MOLECULE_TARGETS:-""}
    IFS=',' read -r -a include_molecule_target_list <<< "$MATCH_MOLECULE_TARGETS"
    if [[ -n "$MATCH_MOLECULE_TARGETS" && ! " ${include_molecule_target_list[@]} " =~ " $target " ]]; then
        echo "Skipping scenario target not in whitelist: $scenario"
        continue
    fi

    SKIP_MOLECULE_TARGET=${SKIP_MOLECULE_TARGET:-""}
    IFS=',' read -r -a skip_molecule_target_list <<< "$SKIP_MOLECULE_TARGET"
    if [[ " ${skip_molecule_target_list[@]} " =~ " $target " ]]; then
        echo "Skipping scenario target not support: $scenario"
        continue
    fi

    MATCH_MOLECULE_CGROUP=${MATCH_MOLECULE_CGROUP:-$(get_current_cgroup_version)}
    if [[ "$cgroup" != "$MATCH_MOLECULE_CGROUP" ]]; then
        echo "Skipping scenario cgroup host wrong: $scenario"
        continue
    fi

    molecule test --scenario-name "$scenario"
done
