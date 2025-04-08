# dsm72-container@any

NOTE: only support molecule `converge` sequence, cant test `create` automatically.

before test, use [dsm72-container@any](../dsm72-container@any/README.md) first,
then go `http://localhost:17000`, create username `docker` with password `4Test@ansible`,
and enable ssh login, it will use by [dsm72-test@any/converge](../dsm72-test@any/converge.yml)

```bash
molecule --debug -vvv test --scenario-name dsm72-test@any
```
