# dsm70-container@any

NOTE: only support molecule `converge` sequence, cant test `create` automatically.

before test, use [dsm70-container@any](../dsm70-container@any/README.md) first,
then go `http://localhost:17000`, create username `docker` with password `4Test@ansible`,
and enable ssh login, it will use by [dsm70-test@any/converge](../dsm70-test@any/converge.yml)

```bash
molecule --debug -vvv test --scenario-name dsm70-test@any
```
