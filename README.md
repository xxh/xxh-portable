The docker containers to build portable [xxh](https://github.com/xxh/xxh).

## Building
### musl
```
./build-xxh-portable-musl-alpine.sh
```

## Example
```
mkdir /tmp/xxh && cd /tmp/xxh
wget https://github.com/xxh/xxh-portable/raw/master/result/xxh-portable-musl-alpine-Linux-x86_64.tar.gz
tar -xzf xxh-portable-musl-alpine-Linux-x86_64.tar.gz
./xxh
```
