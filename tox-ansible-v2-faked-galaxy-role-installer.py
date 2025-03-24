"""Install the role project when Tox Ansible v2 encounters a faked galaxy.yml."""
from ansible_compat.runtime import Runtime
from packaging.version import Version


runtime = Runtime(isolated=True)
runtime._install_galaxy_role(project_dir=runtime.project_dir, role_name_check=2)

v210 = Version("2.10.0")
if runtime.version < v210:
    # fix ansible 2.9 need community.docker < 3.0.0
    # see https://github.com/ansible-collections/community.docker/issues/477
    runtime.install_collection(f"community.docker:<3.0.0")
