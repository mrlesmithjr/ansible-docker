"""Install the role project when Tox Ansible v2 encounters a faked galaxy.yml."""
from ansible_compat.runtime import Runtime


runtime = Runtime(isolated=True)
runtime._install_galaxy_role(project_dir=runtime.project_dir, role_name_check=2)
