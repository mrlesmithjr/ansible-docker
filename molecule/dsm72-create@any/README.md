# dsm72-create@any

NOTE: only support molecule `create` sequence, cat test `converge` automatically.README.md).

```bash
molecule --debug -vvv create --scenario-name dsm72-create@any
```

then go `http://localhost:17200`, create username `docker` with password `4Test@ansible`,
and enable ssh login, it will use by [dsm72-converge@any/converge](../dsm72-converge@any/converge.yml)

after that use [dsm72-converge@any](../dsm72-converge@any/README.md)


finally destroy it

```bash
molecule --debug -vvv destroy --scenario-name dsm72-create@any
```
