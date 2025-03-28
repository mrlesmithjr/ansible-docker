"""Install the role project when Tox Ansible v2 encounters a faked galaxy.yml."""

from ansible_compat.runtime import Runtime
from packaging.version import Version
import molecule
import argparse
import os

# fix `ERROR! the role 'docker' was not found`
# if molecule < 6.0.0, isolated `cache_dir` use `~/.cache/ansible-compat/`
# if molecule >= 6.0.0, isolated disabled not use `~/.ansible/`
# if ansible-compat >= 25.0.0, isolated `cache_dir` use `project_dir/.ansible` not work
isolated = Version(molecule.__version__) < Version("6.0.0")
runtime = Runtime(isolated=isolated)

parser = argparse.ArgumentParser(
    description="Install the role project with Tox Ansible v2 faked galaxy.yml."
)
parser.add_argument(
    "--force",
    action="store_true",
    help="Force reinstallation by removing existing conflict ansible roles symlink.",
)
args = parser.parse_args()
if args.force:
    # Remove conflict directories.
    conflict_runtime = Runtime(isolated=not isolated)
    conflict_cache_dir = conflict_runtime._get_roles_path()
    if conflict_cache_dir.exists() and conflict_cache_dir.is_dir():
        for conflict_symlink_path in conflict_cache_dir.iterdir():
            if conflict_symlink_path.is_symlink() and os.readlink(
                conflict_symlink_path
            ) == str(runtime.project_dir):
                os.unlink(conflict_symlink_path)

runtime._install_galaxy_role(project_dir=runtime.project_dir, role_name_check=2)

v210 = Version("2.10.0")
if runtime.version < v210:
    # fix ansible 2.9 need community.docker < 3.0.0
    # see https://github.com/ansible-collections/community.docker/issues/477
    destination = f"{runtime.cache_dir}/collections"
    runtime.install_collection(
        collection="community.docker:<3.0.0", destination=destination, force=args.force
    )
    runtime.install_collection(
        collection="ansible.posix:>=1.1.0", destination=destination, force=args.force
    )
