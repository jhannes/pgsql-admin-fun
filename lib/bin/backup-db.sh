#!/bin/bash
die () {
    echo >&2 "$@"
    exit 1
}

DATABASE=$1
TARGET_DIR=/backup/db/$DATABASE
TARGET_USER=$USER

[ "$#" -eq 1 ] || die "1 argument required, $# provided"

sudo rm /tmp/$DATABASE.*

sudo -u postgres pg_dump --format=c --file=/tmp/$DATABASE.dmp $DATABASE
sudo -u postgres pg_dump --format=plain --schema-only --file=/tmp/$DATABASE.schema.dmp $DATABASE
sudo -u postgres pg_dump --format=plain --data-only --inserts --table=status_codes --table=countries --file=/tmp/$DATABASE.seed.dmp $DATABASE
sudo chown $TARGET_USER /tmp/$DATABASE.*
bzip2 /tmp/$DATABASE.*dmp

mkdir -p $TARGET_DIR
cp /tmp/$DATABASE.dmp.bz2 $TARGET_DIR/$DATABASE-latest.dmp.bz2
cp /tmp/$DATABASE.dmp.bz2 $TARGET_DIR/$DATABASE-$(date +hr%H).dmp.bz2
cp /tmp/$DATABASE.dmp.bz2 $TARGET_DIR/$DATABASE-$(date +%a).dmp.bz2
cp /tmp/$DATABASE.dmp.bz2 $TARGET_DIR/$DATABASE-$(date +%Y-m%m).dmp.bz2

cp /tmp/$DATABASE.schema.dmp.bz2 $TARGET_DIR/$DATABASE.schema-latest.dmp.bz2
cp /tmp/$DATABASE.seed.dmp.bz2 $TARGET_DIR/$DATABASE.seed-latest.dmp.bz2
