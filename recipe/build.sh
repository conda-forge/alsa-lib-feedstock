#!/bin/bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* .

libtoolize --force --copy --automake
aclocal
autoheader
automake --foreign --copy --add-missing
autoconf
./configure --prefix=$PREFIX --build=$BUILD --host=$HOST
make -j${CPU_COUNT}
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
make check
fi
make install
