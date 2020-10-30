#/bin/bash

SS_VER=3.3.5
SS_URL=https://api.github.com/repos/shadowsocks/shadowsocks-libev/tarball/v${SS_VER}
SS_DIR=shadowsocks-libev-${SS_VER}
LIBIPSET=libipset
LIBIPSET_URL=https://github.com/shadowsocks/ipset/archive/shadowsocks.tar.gz
LIBCORK=libcork
LIBCORK_URL=https://github.com/shadowsocks/libcork/archive/shadowsocks.tar.gz
LIBBLOOM=libbloom
LIBBLOOM_URL=https://github.com/shadowsocks/libbloom/archive/master.tar.gz

# $1 - url $2 - folder
function getsrc() {
    wget -O $2.tar.gz $1
    # mkdir $2;
    tar xfz $2.tar.gz --strip 1 -C $2; \
    rm -rf $2.tar.gz
}

mkdir ${SS_DIR}
getsrc ${SS_URL} ${SS_DIR}
cd ${SS_DIR}
getsrc ${LIBIPSET_URL} ${LIBIPSET}
getsrc ${LIBCORK_URL} ${LIBCORK}
getsrc ${LIBBLOOM_URL} ${LIBBLOOM}
./autogen.sh
./configure --disable-documentation
make install
cd ..
rm -rf ${SS_DIR}