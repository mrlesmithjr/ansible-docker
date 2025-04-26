# windows2025-container@any

NOTE: only support molecule `create` sequence, cant test `converge` automatically.

```bash
molecule --debug -vvv create --scenario-name windows2025-container@any
```

then go `http://localhost:8256`, create username `docker` with password `4Test@ansible`,
and enable ssh login, it will use by [windows2025-test@any/converge](../windows2025-test@any/converge.yml)

after that use [windows2025-test@any](../windows2025-test@any/README.md)


finally destroy it

```bash
molecule --debug -vvv destroy --scenario-name windows2025-container@any
```
