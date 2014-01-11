cd $VIRTUAL_ENV/src

# xapian
wget http://oligarchy.co.uk/xapian/1.2.15/xapian-core-1.2.15.tar.gz
tar xzf xapian-core-1.2.15.tar.gz
cd xapian-core-1.2.15
./configure --prefix=${VIRTUAL_ENV} && make && make install
cd -

# xapian python bindings
wget http://oligarchy.co.uk/xapian/1.2.15/xapian-bindings-1.2.15.tar.gz
tar xzf xapian-bindings-1.2.15.tar.gz
cd xapian-bindings-1.2.15
./configure --prefix=${VIRTUAL_ENV} --with-python \
    --without-php --without-ruby --without-tcl --without-csharp \
    --without-java --without-perl --without-lua && make && make install
cd -