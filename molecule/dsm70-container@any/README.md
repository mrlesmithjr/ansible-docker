# dsm70-container@any

NOTE: only support molecule `create` sequence, cant test `converge` automatically.

```bash
molecule --debug -vvv create --scenario-name dsm70-container@any
```

then go `http://localhost:17000`, create username `docker` with password `4Test@ansible`,
and enable ssh login, it will use by [dsm70-test@any/converge](../dsm70-test@any/converge.yml)

after that use [dsm70-test@any](../dsm70-test@any/README.md)


finally destroy it

```bash
molecule --debug -vvv destroy --scenario-name dsm70-container@any
```
