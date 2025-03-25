"""Tests for molecule scenarios."""

from __future__ import absolute_import, division, print_function

from pytest_ansible.molecule import MoleculeScenario

import pytest
import os


def test_integration(molecule_scenario: MoleculeScenario) -> None:
    """Run molecule for each scenario.

    :param molecule_scenario: The molecule scenario object
    """
    if molecule_scenario.parent_directory.as_posix() != os.environ.get(
        "MOLECULE_PROJECT_DIRECTORY", ""
    ):
        pytest.skip(
            "Skipping scenario path not match: {}".format(
                molecule_scenario.parent_directory
            )
        )
        return

    target, cgroup = molecule_scenario.name.split("@")

    include_molecule_target_env = os.getenv("MATCH_MOLECULE_TARGETS", "")
    include_molecule_target_list = include_molecule_target_env.split(",")
    if include_molecule_target_env and target not in include_molecule_target_list:
        pytest.skip(
            "Skipping scenario target not in whitelist: {}".format(
                molecule_scenario.name
            )
        )
        return
    skip_molecule_target_env = os.environ.get("SKIP_MOLECULE_TARGET", "")
    skip_molecule_target_list = skip_molecule_target_env.split(",")
    if target in skip_molecule_target_list:
        pytest.skip(
            "Skipping scenario target not support: {}".format(molecule_scenario.name)
        )
        return
    if cgroup != os.environ.get("MATCH_MOLECULE_CGROUP", get_current_cgroup_version()):
        pytest.skip(
            "Skipping scenario cgroup host wrong: {}".format(molecule_scenario.name)
        )
        return

    proc = molecule_scenario.test()
    if proc.returncode == 0:
        print("Scenario passed: {}".format(molecule_scenario.name))
    assert proc.returncode == 0


def get_current_cgroup_version() -> str:
    cgroup_v2_path = "/sys/fs/cgroup/cgroup.controllers"
    if os.path.exists(cgroup_v2_path):
        return "cgroupv2"
    return "cgroupv1"
