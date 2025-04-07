# dsm71-create@any

NOTE: only support molecule `converge` sequence, cat test `create` automatically.

before test, use [dsm71-create@any](../dsm71-create@any/README.md) first,
then go `http://localhost:17100`, create username `docker` with password `4Test@ansible`,
and enable ssh login, it will use by [dsm71-converge@any/converge](../dsm71-converge@any/converge.yml)

```bash
molecule --debug -vvv converge --scenario-name dsm71-converge@any
```
