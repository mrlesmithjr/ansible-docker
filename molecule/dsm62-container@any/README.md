# dsm62-container@any

NOTE: only support molecule `create` sequence, cat test `converge` automatically.README.md).

```bash
molecule --debug -vvv create --scenario-name dsm62-container@any
```

then go `http://localhost:16200`, create username `docker` with password `4Test@ansible`,
and enable ssh login, it will use by [dsm62-test@any/converge](../dsm62-test@any/converge.yml)

after that use [dsm62-test@any](../dsm62-test@any/README.md)


finally destroy it

```bash
molecule --debug -vvv destroy --scenario-name dsm62-container@any
```
