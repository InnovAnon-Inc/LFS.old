set -eo nounset

cd /sources

rm -rf attr-2.4.47
tar xf attr-2.4.47.src.tar.gz
pushd  attr-2.4.47

sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in

sed -i -e "/SUBDIRS/s|man[25]||g" man/Makefile

sed -i 's:{(:\\{(:' test/run

./configure --prefix=/usr \
            --bindir=/bin \
            --disable-static

make

#make -j1 tests root-tests

make install install-dev install-lib
chmod -v 755 /usr/lib/libattr.so

mv -v /usr/lib/libattr.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libattr.so) /usr/lib/libattr.so

popd
rm -rf attr-2.4.47
