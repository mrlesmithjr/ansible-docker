# dsm71-container@any

NOTE: only support molecule `create` sequence, cat test `converge` automatically.README.md).

```bash
molecule --debug -vvv create --scenario-name dsm71-container@any
```

then go `http://localhost:17100`, create username `docker` with password `4Test@ansible`,
and enable ssh login, it will use by [dsm71-test@any/converge](../dsm71-test@any/converge.yml)

after that use [dsm71-test@any](../dsm71-test@any/README.md)


finally destroy it

```bash
molecule --debug -vvv destroy --scenario-name dsm71-container@any
```
