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

auto find system python verison by [tool.poetry.dependencies]

```bash
poetry env use python3
```

OR manually use Python 3.8 from pyenv to test Ansible <= 2.13.

```bash
poetry env use $(pyenv which python3.8)
```

OR manually use Python 3.11 from pyenv to test Ansible >= 2.14.

```bash
poetry env use $(pyenv which python3.11)
```

### Install dependencies

install poetry group dependencies for python version environment

- if in python 3.8 environment

    ```bash
    # install python 3.8 dependencies
    poetry install --with py38
    # OR just restore completely python 3.8 dependencies
    poetry run pip install -r requirements-py38.txt
    ```

- if in python 3.11 environment

    ```bash
    # install python 3.11 dependencies
    poetry install --with py311
    # OR just restore completely python 3.11 dependencies
    poetry run pip install -r requirements-py311.txt
    ```

install `dependency-groups` for ansible version

- if in python 3.8 environment you can install ansible <= 2.13

    ```bash
    # if in python 3.8 environment
    # print dependency groups for ansible 2.11
    poetry run python -m dependency_groups requests ansible211
    # install dependency groups for ansible 2.11
    poetry run pip-install-dependency-groups requests ansible211
    ```

- if in python 3.11 environment you can install ansible >= 2.14

    ```bash
    # print dependency groups for ansible 2.14
    poetry run python -m dependency_groups requests ansible214
    # install dependency groups for ansible 2.14
    poetry run pip-install-dependency-groups requests ansible214
    ```

### Export pyproject.toml to requirements

after some dependencies change in `pyproject.toml`

```bash
# like update molecule new version
poetry update molecule
poetry lock
```

- if in python 3.8 environment

    ```bash
    # export python 3.8 dependencies
    poetry export --without-hashes --only=py38 --output requirements-py38.txt
    ```

- if in python 3.11 environment

    ```bash
    # export python 3.11 dependencies
    poetry export --without-hashes --only=py311 --output requirements-py311.txt
    ```

### Fix linting errors

```bash
SKIP=no-commit-to-branch poetry run pre-commit run --all-files
# OR use
poetry run ansible-lint .
```

### Test molecule scenario

- if ansible-core <= 2.11 set use old ansible-galaxy

    ```bash
    export ANSIBLE_CONFIG=$(pwd)/molecule/ansible.old-galaxy.cfg
    ```

then

- if on cgroup v1 host, use scenario name like `{target}@cgroupv1`

    alone test on cgroup v1 host

    ```bash
    poetry run molecule --debug -vvv test --scenario-name centos7@cgroupv1
    poetry run molecule --debug -vvv test --scenario-name centos8@cgroupv1
    poetry run molecule --debug -vvv test --scenario-name debian9@cgroupv1
    poetry run molecule --debug -vvv test --scenario-name debian10@cgroupv1
    poetry run molecule --debug -vvv test --scenario-name ubuntu1604@cgroupv1
    poetry run molecule --debug -vvv test --scenario-name ubuntu1804@cgroupv1
    poetry run molecule --debug -vvv test --scenario-name ubuntu2004@cgroupv1
    ```

    batch test on cgroup v1 host

    ```bash
    # no skip any `{target}@*` scenario
    export SKIP_MOLECULE_TARGET=
    # filter only `{target}@cgroupv1` scenario
    export MATCH_MOLECULE_CGROUP=cgroupv1
    bash molecule-test-cgroup-filter.sh
    ```

- if on cgroup v2 host, use scenario name like `{target}@cgroupv2`

    alone test on cgroup v2 host

    ```bash
    poetry run molecule --debug -vvv test --scenario-name centos7@cgroupv2
    poetry run molecule --debug -vvv test --scenario-name centos8@cgroupv2
    poetry run molecule --debug -vvv test --scenario-name debian9@cgroupv2
    poetry run molecule --debug -vvv test --scenario-name debian10@cgroupv2
    # some target like `ubuntu1604` not support cgroupv2
    # poetry run molecule --debug -vvv test --scenario-name ubuntu1604@cgroupv2
    poetry run molecule --debug -vvv test --scenario-name ubuntu1804@cgroupv2
    poetry run molecule --debug -vvv test --scenario-name ubuntu2004@cgroupv2
    ```

    batch test on cgroup v2 host

    ```bash
    # no skip any `{target}@*` scenario
    export SKIP_MOLECULE_TARGET=debian9,ubuntu1604
    # filter only `{target}@cgroupv2` scenario
    export MATCH_MOLECULE_CGROUP=cgroupv2
    bash molecule-test-cgroup-filter.sh
    ```

### Test tox environment

activate poetry environment before tox test

```bash
$(poetry env activate)
```

- if on cgroup v1 host

    ```bash
    # output first then run tox test
    bash tox-ansible.sh --cgroup=v1 --stdout
    # run tox test
    bash tox-ansible.sh --cgroup=v1
    ```

- if on cgroup v2 host

    ```bash
    # output first then run tox test
    bash tox-ansible.sh --cgroup=v2 --stdout
    # run tox test
    bash tox-ansible.sh --cgroup=v2
    ```

### New target test

activate poetry environment before tox test

```bash
$(poetry env activate)
```

- add new molecule scenario in ./molecule path, named format like `<target>@<cgroup>`
- test target in each tox environment

 - batch test in each python and ansible version on cgroupv1 host

    ```bash
    # <target> name like `debian11` `ubuntu2204,ubuntu2404`
    # output first then run tox test
    bash tox-ansible.sh --target=<target> --cgroup=v1 --stdout
    # run tox test
    bash tox-ansible.sh --target=<target> --cgroup=v1
    ```

- batch test in each python and ansible version on cgroupv2 host

    ```bash
    # <target> name like `debian11` `ubuntu2204,ubuntu2404`
    # output first then run tox test
    bash tox-ansible.sh --target=<target> --cgroup=v2 --stdout
    # run tox test
    bash tox-ansible.sh --target=<target> --cgroup=v2
    ```

- batch test in each python and ansible version auto detect host cgroup version

    ```bash
    # <target> name like `debian11` `ubuntu2204,ubuntu2404`
    # output first then run tox test
    bash tox-ansible.sh --target=<target> --stdout
    # run tox test
    bash tox-ansible.sh --target=<target>
    ```

## Test non-automated (manual)

The current Synology DSM system can run inside Docker,
supported by the [virtual-dsm](https://github.com/vdsm/virtual-dsm) project.
Since virtual-dsm uses QEMU virtualization, DSM actually runs within the QEMU virtual machine.
Ansible Molecule, when using the [docker-connection](https://docs.ansible.com/ansible/latest/collections/community/docker/docker_connection.html),
can only access the base container running QEMU and cannot connect deeper into the DSM system.
Therefore, fully unattended automated testing is currently not feasible.

If you would like to perform testing, you need to follow the steps in the table below and manually handle some tasks between the two scenarios.

- First, use *-container@any to create the container
- Then access the DSM web interface to create a user and enable SSH
- Next, use *-test@any to run the test
- Finally use *-container@any to remove the container

| target | *-container@any | *-test@any |
|-----|-----|-----|
| DSM 6.2 | [dsm62-container@any](molecule/dsm62-container@any/README.md) | [dsm62-test@any](molecule/dsm62-test@any/README.md) |
| DSM 7.0 | [dsm70-container@any](molecule/dsm70-container@any/README.md) | [dsm70-test@any](molecule/dsm70-test@any/README.md) |
| DSM 7.1 | [dsm71-container@any](molecule/dsm71-container@any/README.md) | [dsm71-test@any](molecule/dsm71-test@any/README.md) |
| DSM 7.2 | [dsm72-container@any](molecule/dsm72-container@any/) | [dsm72-test@any](molecule/dsm72-test@any/) |
