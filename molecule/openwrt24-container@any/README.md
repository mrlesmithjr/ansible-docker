# openwrt24-container@any

NOTE: only support molecule `create` sequence, cant test `converge` automatically.

```bash
molecule --debug -vvv create --scenario-name openwrt24-container@any
```

then go `http://localhost:24006`, create username `docker` with password `4Test@ansible`,
and enable ssh login, it will use by [openwrt24-test@any/converge](../openwrt24-test@any/converge.yml)

after that use [openwrt24-test@any](../openwrt24-test@any/README.md)


finally destroy it

```bash
molecule --debug -vvv destroy --scenario-name openwrt24-container@any
```
