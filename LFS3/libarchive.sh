cd /sources

test -f libarchive-3.3.2.tar.gz || \
wget --no-check-certificate \
	http://www.libarchive.org/downloads/libarchive-3.3.2.tar.gz

rm -rf libarchive-3.3.2
tar xf libarchive-3.3.2.tar.gz
cd libarchive-3.3.2

./configure --prefix=/usr --disable-static
make

make install
