# `cfs-freertos`

This is a skeleton cFS flight distribution comprising [cFE](https://github.com/nasa/cfe), [OSAL](https://github.com/osal), and [PSP](https://github.com/nasa/psp) with support for [FreeRTOS](https://freertos.org).

**This is a work in progress.**

## Building cFS

Fetch any git submodules:

```
git pull
git submodule update --init --recursive
```

On a Linux host computer:

```
docker-compose run mps2 bash
```

Then, inside the Ubuntu 18.04 docker container:

```
make
```

The relevant `cmake` configuration files are identified in `mps2_defs/`.

## Running in QEMU

Emulate in QEMU:

```
qemu-system-arm \
    -machine mps2-an385 \
    -monitor null \
    -semihosting \
    --semihosting-config enable=on,target=native \
    -kernel ./build-mps2/cortex-m3/default_mps2/mps2/core-mps2 \
    -serial stdio \
    -nographic \
    -gdb tcp::5555 \
    -S
```

Debug in `gdb`:

```
arm-none-eabi-gdb-py \
    --ex "target extended-remote localhost:5555" \
    -x ./apps/bsp-arm-mps2-an385/scripts/gdb/debug.gdbinit \
    -q ./build-mps2/cortex-m3/default_mps2/mps2/core-mps2
```


### Bootstrapping on a Linux host computer

The toolchain is separately installed in the Docker container but it can also be useful to have certain host binaries available on the host computer. The gcc cross toolchain for ARM is installed like so:

```
export CFS_PROJECT_PATH=/opt/cfs-freertos

mkdir -p ${CFS_PROJECT_PATH}/toolchain

wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 | tar xvj -C ${CFS_PROJECT_PATH}/toolchain/

export PATH="${PATH}:${CFS_PROJECT_PATH}/toolchain/gcc-arm-none-eabi-9-2019-q4-major/bin"
```

You also need to install Docker and `docker-compose`.