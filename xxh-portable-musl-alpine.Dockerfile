FROM alpine
VOLUME /result

ENV PYTHON_VER 3.8.2
ENV PYTHON_LIB_VER 3.8

RUN apk update && apk add --update musl-dev gcc python3-dev py3-pip chrpath git vim mc wget make openssh-client
RUN pip3 install -U pip
RUN pip3 install -U "https://github.com/Nuitka/Nuitka/archive/factory.zip"
RUN pip3 install pexpect pyyaml


RUN mkdir /build /package
WORKDIR /build

RUN wget https://www.python.org/ftp/python/$PYTHON_VER/Python-$PYTHON_VER.tgz && tar -xzf Python-$PYTHON_VER.tgz
WORKDIR Python-$PYTHON_VER
ADD Setup.local Modules/
RUN ./configure LDFLAGS="-static" --disable-shared
RUN make LDFLAGS="-static" LINKFORSHARED=" "
RUN cp libpython$PYTHON_LIB_VER.a /usr/lib

RUN echo 'xxh 0.8.6'

WORKDIR /build
RUN git clone --depth 1 https://github.com/xxh/xxh
ENV LDFLAGS "-static -l:libpython3.8.a"
RUN nuitka3 --python-flag=no_site --python-flag=no_warnings --show-progress --standalone --follow-imports xxh/xxh
RUN ls -la

WORKDIR xxh.dist
RUN ./xxh -V
RUN cp xxh /build/xxh/xxh_xxh/xxh.*sh /build/xxh/xxh_xxh/*.xxhc  /package
WORKDIR /package
CMD tar -zcf /result/xxh-portable-musl-alpine-`uname`-`uname -m`.tar.gz * && ls -sh1 /result
