if [ ! -z "$PREFIX" ] && [ "$PREFIX" = "/data/data/com.termux/files/usr" ]; then
    # quick hack to enable testing in termux
    export CPPFLAGS='-Dpthread_mutexattr_setprotocol(a,b)={} -Wno-unused-but-set-variable'
fi
make -C WDL/WDL/eel2 NO_GFX=1
