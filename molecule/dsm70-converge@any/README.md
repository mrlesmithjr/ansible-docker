# dsm70-create@any

NOTE: only support molecule `converge` sequence, cat test `create` automatically.

before test, use [dsm70-create@any](../dsm70-create@any/README.md) first,
then go `http://localhost:17000`, create username `docker` with password `4Test@ansible`,
and enable ssh login, it will use by [dsm70-converge@any/converge](../dsm70-converge@any/converge.yml)

```bash
molecule --debug -vvv converge --scenario-name dsm70-converge@any
```
