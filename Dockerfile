# Container image that runs your code
FROM stoneatom/stonedb80_buildenv

RUN /bin/bash -c 'git clone -b stonedb-8.0-dev https://github.com/stoneatom/stonedb.git'
RUN /bin/bash -c 'cd stonedb && mkdir build && cd build'
RUN /bin/bash -c 'cmake .. \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_PREFIX=/stonedb8/install \
-DMYSQL_DATADIR=/stonedb8/install/data \
-DSYSCONFDIR=/stonedb8/install \
-DMYSQL_UNIX_ADDR=/stonedb8/install/tmp/mysql.sock \
-DWITH_BOOST=/usr/local/stonedb-boost \
-DWITH_MARISA=/usr/local/stonedb-marisa \
-DWITH_ROCKSDB=/usr/local/stonedb-gcc-rocksdb'
RUN /bin/bash -c 'make -j `nproc` && make install -j`nproc`'