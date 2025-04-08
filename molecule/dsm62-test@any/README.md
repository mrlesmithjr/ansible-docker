# dsm62-container@any

NOTE: DSM 6.2 only support python 2, so use ansible 2.16 molecule environment

```bash
. ./.tox/molecule-py3.10-2.16/bin/activate
```

NOTE: only support molecule `converge` sequence, cant test `create` automatically.

before test, use [dsm62-container@any](../dsm62-container@any/README.md) first,
then go `http://localhost:16200`, create username `docker` with password `4Test@ansible`,
and enable ssh login, it will use by [dsm62-test@any/converge](../dsm62-test@any/converge.yml)

```bash
molecule --debug -vvv test --scenario-name dsm62-test@any
```
