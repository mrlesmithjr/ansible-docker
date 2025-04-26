# openwrt24-test@any

NOTE: cant test on WSL2, some network issue make ssh cant connect again.

NOTE: only support molecule `converge` sequence, cant test `create` automatically.

before test, use [openwrt24-container@any](../openwrt24-container@any/README.md) first,
then go `http://localhost:24006`, create username `docker` with password `4Test@ansible`,
and enable ssh login, it will use by [openwrt24-test@any/converge](../openwrt24-test@any/converge.yml)

```bash
molecule --debug -vvv test --scenario-name openwrt24-test@any
```
