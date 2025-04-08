# dsm71-container@any

NOTE: only support molecule `converge` sequence, cant test `create` automatically.

before test, use [dsm71-container@any](../dsm71-container@any/README.md) first,
then go `http://localhost:17100`, create username `docker` with password `4Test@ansible`,
and enable ssh login, it will use by [dsm71-test@any/converge](../dsm71-test@any/converge.yml)

```bash
molecule --debug -vvv test --scenario-name dsm71-test@any
```
