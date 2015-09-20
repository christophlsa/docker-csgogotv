#!/bin/bash
set -e

if [ "$1" = 'gotv' ]; then
    shift

	# update
	cd /opt/steamcmd &&\
    ./steamcmd.sh \
        +login anonymous \
        +force_install_dir ../csgo \
        +app_update 740 \
        +quit
	
	cd /opt/csgo &&\
	./srcds_run -game csgo -console +tv_relay "$@"
	exit 0
fi

exec "$@"