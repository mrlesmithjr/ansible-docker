#!/bin/bash

get_current_cgroup_version() {
    if [[ -f /sys/fs/cgroup/cgroup.controllers ]]; then
        echo "cgroupv2"
    else
        echo "cgroupv1"
    fi
}

script_name=$(basename "$0")
ansible=$(ansible --version | grep -oP 'ansible (\[core )?\K[0-9]+\.[0-9]+')

scenarios=()
while IFS= read -r line; do
    scenario=$(echo "$line" | awk '{print $4}' | sed 's/^ *//;s/ *$//')
    if [[ -n "$scenario" ]]; then
        scenarios+=("$scenario")
    fi
done < <(molecule list -f plain 2>/dev/null)

output=""
time_start=$SECONDS
count_passed=0
count_skipped=0
count_failed=0

for scenario in "${scenarios[@]}"; do
    IFS='@' read -r target cgroup <<< "$scenario"

    MATCH_MOLECULE_TARGETS=${MATCH_MOLECULE_TARGETS:-""}
    IFS=',' read -r -a include_molecule_target_list <<< "$MATCH_MOLECULE_TARGETS"
    if [[ -n "$MATCH_MOLECULE_TARGETS" && ! " ${include_molecule_target_list[@]} " =~ " $target " ]]; then
        output+="SKIPPED $script_name: Skipping scenario target not in whitelist: $scenario\n"
        ((count_skipped++))
        continue
    fi

    SKIP_MOLECULE_TARGET=${SKIP_MOLECULE_TARGET:-""}
    IFS=',' read -r -a skip_molecule_target_list <<< "$SKIP_MOLECULE_TARGET"
    if [[ " ${skip_molecule_target_list[@]} " =~ " $target " ]]; then
        output+="SKIPPED $script_name: Skipping scenario target not support: $scenario\n"
        ((count_skipped++))
        continue
    fi

    MATCH_MOLECULE_CGROUP=${MATCH_MOLECULE_CGROUP:-$(get_current_cgroup_version)}
    if [[ "$cgroup" != "$MATCH_MOLECULE_CGROUP" ]]; then
        output+="SKIPPED $script_name: Skipping scenario cgroup host wrong: $scenario\n"
        ((count_skipped++))
        continue
    fi

    molecule test --scenario-name "$scenario"

    exit_code=$?
    if [[ $exit_code -eq 0 ]]; then
        output+="PASSED $script_name: Scenario $scenario\n"
        ((count_passed++))
    else
        output+="FAILED $script_name: Scenario $scenario exit code: $exit_code\n"
        ((count_failed++))
    fi
done

time_end=$SECONDS
time_elapsed=$((time_end - start_time))
minutes=$((time_elapsed / 60))
seconds=$((time_elapsed % 60))

bar_width=100

summary_start="short test summary info"
summary_length=${#summary_start}
equal_count=$(((bar_width - summary_length - 2) / 2))
border="$(printf '=%.0s' $(seq 1 $equal_count))"
echo "$border $summary_start $border"

echo -e "$output"

summary_end="$count_passed passed, $count_failed failed, $count_skipped skipped in ${time_elapsed}s (${minutes}:${seconds})"
summary_length=${#summary_end}
equal_count=$(((bar_width - summary_length - 2) / 2))
border="$(printf '=%.0s' $(seq 1 $equal_count))"
echo "$border $summary_end $border"

if [[ $count_failed -gt 0 ]]; then
    exit 1
fi
