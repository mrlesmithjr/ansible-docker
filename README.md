# ansible-docker

An [Ansible](https://www.ansible.com) role to install and configure [Docker](https://docs.docker.com).

## Ansible Galaxy

```bash
ansible-galaxy install mrlesmithjr.docker
```

## Requirements

Run with `become: true`.

### Collections

Install required collections before running the role:

```bash
ansible-galaxy collection install -r requirements.yml
```

| Collection | Minimum Version |
|------------|----------------|
| `community.docker` | 3.0.0 |
| `community.general` | 7.0.0 |
| `ansible.posix` | 1.5.0 |

## Role Variables

See [defaults/main.yml](defaults/main.yml) for the full variable reference.

### Storage driver

| Variable | Default | Description |
|----------|---------|-------------|
| `docker_storage_driver` | `""` | Storage driver to use. Empty string (default) means no `storage-driver` key is written to `daemon.json` — Docker picks its own default. Set to `"zfs"` to enable ZFS support. |
| `docker_zfs_dataset` | `""` | ZFS dataset path when `docker_storage_driver == "zfs"`. Created automatically if set. Leave empty to use Docker's default data-root (`/var/lib/docker`). |

**ZFS platform note:** `docker_storage_driver: "zfs"` is Debian and Ubuntu only. The role fails with a clear error on RHEL-family hosts.

## Example Playbook

```yaml
- hosts: docker_hosts
  become: true
  roles:
    - role: mrlesmithjr.docker
```

With ZFS storage:

```yaml
- hosts: docker_hosts
  become: true
  roles:
    - role: mrlesmithjr.docker
      vars:
        docker_storage_driver: "zfs"
        docker_zfs_dataset: "tank/docker"
```

When `docker_storage_driver: "zfs"`, the role installs `zfsutils-linux`, creates the dataset if `docker_zfs_dataset` is set, and injects the `storage-driver` key into `/etc/docker/daemon.json`.

## Testing

The role is validated by GitHub Actions (`.github/workflows/default.yml`) on every push and pull request. CI runs two jobs:

- **Lint**: `yamllint` and `ansible-lint` (production profile) after installing collections from `requirements.yml`
- **Syntax Check**: `ansible-playbook tests/test.yml --syntax-check` across ansible-core 2.15, 2.16, 2.17, and 2.18

To run the same checks locally:

```bash
pip install ansible-lint yamllint
ansible-galaxy collection install -r requirements.yml
yamllint .
ansible-lint
```

## License

MIT

## Author

Larry Smith Jr. — [everythingshouldbevirtual.com](http://everythingshouldbevirtual.com) · [mrlesmithjr@gmail.com](mailto:mrlesmithjr@gmail.com)
