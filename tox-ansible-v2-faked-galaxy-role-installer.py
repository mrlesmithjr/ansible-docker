"""Install the role project when Tox Ansible v2 encounters a faked galaxy.yml."""

from ansible_compat.runtime import Runtime
from packaging.version import Version
import molecule


# fix `ERROR! the role 'docker' was not found`
# if molecule < 6.0.0, isolated `cache_dir` use `~/.cache/ansible-compat/`
# if molecule >= 6.0.0, isolated disabled not use `~/.ansible/`
# if ansible-compat >= 25.0.0, isolated `cache_dir` use `project_dir/.ansible` not work
isolated = Version(molecule.__version__) < Version("6.0.0")
runtime = Runtime(isolated=isolated)
runtime._install_galaxy_role(project_dir=runtime.project_dir, role_name_check=2)

v210 = Version("2.10.0")
if runtime.version < v210:
    # fix ansible 2.9 need community.docker < 3.0.0
    # see https://github.com/ansible-collections/community.docker/issues/477
    destination = f"{runtime.cache_dir}/collections"
    runtime.install_collection(
        collection="community.docker:<3.0.0", destination=destination
    )
