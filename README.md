# ansible-docker

Ansible role to install/configure Docker

## Build Status

### GitHub Actions

[![Molecule Test](../../actions/workflows/test-molecule.yml/badge.svg)](../../actions/workflows/test-molecule.yml)

[![Tox Test](../../actions/workflows/test-tox.yml/badge.svg)](../../actions/workflows/test-tox.yml)

## Requirements

For any required Ansible roles, review:
[requirements.yml](requirements.yml)

## Role Variables

[defaults/main.yml](defaults/main.yml)

## Dependencies

## Example Playbook

[playbook.yml](playbook.yml)

## License

MIT

## Author Information

Larry Smith Jr.

- [@mrlesmithjr](https://twitter.com/mrlesmithjr)
- [mrlesmithjr@gmail.com](mailto:mrlesmithjr@gmail.com)
- [http://everythingshouldbevirtual.com](http://everythingshouldbevirtual.com)

> NOTE: Repo has been created/updated using [https://github.com/mrlesmithjr/cookiecutter-ansible-role](https://github.com/mrlesmithjr/cookiecutter-ansible-role) as a template.


## Development flow

### Install pipx for poetry

```bash
pip install pipx
pipx ensurepath
pipx install 'poetry>=2.0.0'
pipx inject poetry poetry-plugin-export
```

### Create env by poetry

```bash
# auto find system python verison by [tool.poetry.dependencies]
poetry env use
# OR use pyenv to find the path to the python3.8 executable
poetry env use $(pyenv which python3.8)
```

### Install dependencies

```bash
# auto update dependencies
poetry install
# OR restore completely dependencies
poetry run pip install -r requirements-dev.txt
```

### Export pyproject.toml to requirements

after add some new dependencies

```bash
poetry update molecule
```


```bash
poetry lock
poetry export --without-hashes --only=dev --output requirements-dev.txt
```

### Fix linting errors

```bash
SKIP=no-commit-to-branch poetry run pre-commit run --all-files
# OR use
poetry run ansible-lint .
```

### Test molecule scenario

```bash
export ANSIBLE_CONFIG=$(pwd)/molecule/ansible.old-galaxy.cfg
# if on cgroupv1 host
poetry run molecule --debug -vvv test --scenario-name centos7@cgroupv1
poetry run molecule --debug -vvv test --scenario-name centos8@cgroupv1
poetry run molecule --debug -vvv test --scenario-name debian9@cgroupv1
poetry run molecule --debug -vvv test --scenario-name debian10@cgroupv1
poetry run molecule --debug -vvv test --scenario-name ubuntu1604@cgroupv1
poetry run molecule --debug -vvv test --scenario-name ubuntu1804@cgroupv1
poetry run molecule --debug -vvv test --scenario-name ubuntu2004@cgroupv1
# if on cgroupv2 host
poetry run molecule --debug -vvv test --scenario-name centos7@cgroupv2
poetry run molecule --debug -vvv test --scenario-name centos8@cgroupv2
poetry run molecule --debug -vvv test --scenario-name debian9@cgroupv2
poetry run molecule --debug -vvv test --scenario-name debian10@cgroupv2
# poetry run molecule --debug -vvv test --scenario-name ubuntu1604@cgroupv2
poetry run molecule --debug -vvv test --scenario-name ubuntu1804@cgroupv2
poetry run molecule --debug -vvv test --scenario-name ubuntu2004@cgroupv2
```

### Test tox environment

```bash
export ANSIBLE_CONFIG=$(pwd)/molecule/ansible.old-galaxy.cfg
# if on cgroupv1 host
# output first then run tox test
bash tox-ansible.sh --cgroup=v1 --stdout
bash tox-ansible.sh --cgroup=v1
# if on cgroupv2 host
bash tox-ansible.sh --cgroup=v2 --stdout
bash tox-ansible.sh --cgroup=v2
```
