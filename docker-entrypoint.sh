#! /bin/sh

# Setup timezone ate runtime using TZ environment variable 
cp /usr/share/zoneinfo/${TZ} /etc/localtime

if [ "$1" = 'sarah-server.sh' ]; then
    exec /home/pi/sarah-server/sarah-server.sh $@
fi

exec $@
