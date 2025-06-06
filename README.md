# ansible-docker

Ansible role to install/configure Docker

## Build Status

### GitHub Actions

[![Molecule Test](../../actions/workflows/test-molecule.yml/badge.svg)](../../actions/workflows/test-molecule.yml)

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
pipx install poetry
pipx inject poetry poetry-plugin-export
```

### Create env by poetry

```bash
# auto find system python verison by [tool.poetry.dependencies]
poetry env use
# OR use pyenv to find the path to the python3.9 executable
poetry env use $(pyenv which python3.9)
```

### Install dependencies

```bash
# auto update dependencies
poetry install
# OR restore completely dependencies
poetry run pip install -r requirements.txt -r requirements-dev.txt
```

### Export pyproject.toml to requirements

after add some new dependencies

```
poetry update molecule
```


```bash
poetry lock
poetry export --without-hashes --output requirements.txt
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
poetry run molecule --debug -vvv test --scenario-name centos7
poetry run molecule --debug -vvv test --scenario-name centos8
poetry run molecule --debug -vvv test --scenario-name debian9
poetry run molecule --debug -vvv test --scenario-name debian10
poetry run molecule --debug -vvv test --scenario-name ubuntu1604
poetry run molecule --debug -vvv test --scenario-name ubuntu1804
poetry run molecule --debug -vvv test --scenario-name ubuntu2004
```
