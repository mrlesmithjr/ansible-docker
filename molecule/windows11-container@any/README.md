# windows11-container@any

NOTE: only support molecule `create` sequence, cant test `converge` automatically.

```bash
molecule --debug -vvv create --scenario-name windows11-container@any
```

then go `http://localhost:8116`, create username `docker` with password `4Test@ansible`,
and enable ssh login, it will use by [windows11-test@any/converge](../windows11-test@any/converge.yml)

after that use [windows11-test@any](../windows11-test@any/README.md)


finally destroy it

```bash
molecule --debug -vvv destroy --scenario-name windows11-container@any
```
