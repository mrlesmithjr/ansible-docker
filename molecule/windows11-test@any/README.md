# windows11-test@any

NOTE: You need to manually restart the Windows container in order to proceed with the RUNNING HANDLER [docker : Reboot system] task, especially when encountering the TianoCore boot hang issue.

NOTE: only support molecule `converge` sequence, cant test `create` automatically.

before test, use [windows11-container@any](../windows11-container@any/README.md) first,
then go `http://localhost:8116`, create username `docker` with password `4Test@ansible`,
and enable ssh login, it will use by [windows11-test@any/converge](../windows11-test@any/converge.yml)

```bash
molecule --debug -vvv test --scenario-name windows11-test@any
```
