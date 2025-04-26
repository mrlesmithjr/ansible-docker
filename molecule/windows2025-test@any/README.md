# windows2025-test@any

NOTE: You need to manually restart the Windows container in order to proceed with the RUNNING HANDLER [docker : Reboot system] task, especially when encountering the TianoCore boot hang issue.

NOTE: only support molecule `converge` sequence, cant test `create` automatically.

before test, use [windows2025-container@any](../windows2025-container@any/README.md) first,
then go `http://localhost:8256`, create username `docker` with password `4Test@ansible`,
and enable ssh login, it will use by [windows2025-test@any/converge](../windows2025-test@any/converge.yml)

```bash
molecule --debug -vvv test --scenario-name windows2025-test@any
```
