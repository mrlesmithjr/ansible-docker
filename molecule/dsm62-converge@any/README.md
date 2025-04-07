# dsm62-create@any

NOTE: DSM 6.2 only support python 2, so use ansible 2.16 molecule environment

```bash
. ./.tox/molecule-py3.10-2.16/bin/activate
```

NOTE: only support molecule `converge` sequence, cat test `create` automatically.

before test, use [dsm62-create@any](../dsm62-create@any/README.md) first,
then go `http://localhost:16200`, create username `docker` with password `4Test@ansible`,
and enable ssh login, it will use by [dsm62-converge@any/converge](../dsm62-converge@any/converge.yml)

```bash
molecule --debug -vvv converge --scenario-name dsm62-converge@any
```
