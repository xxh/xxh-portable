#!/bin/bash

docker build . -f xxh-portable-musl-alpine.Dockerfile -t xxh/xxh-portable-musl-alpine  #--no-cache --force-rm
docker run --rm -v `pwd`/result:/result xxh/xxh-portable-musl-alpine
