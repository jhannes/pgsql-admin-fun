#!/bin/bash
die () {
    echo >&2 "$@"
    exit 1
}

STANDBY=$1
PG_DATA=/var/lib/postgresql/9.3/main/

[ "$#" -eq 1 ] || die "1 argument required, $# provided"


ssh-keyscan $STANDBY >> ~/.ssh/known_hosts
service postgresql stop
ssh $STANDBY service postgresql stop
rsync -av --exclude pg_xlog --exclude postgresql.conf $PG_DATA $STANDBY:$PG_DATA
ssh $STANDBY service postgresql start
service postgresql start
