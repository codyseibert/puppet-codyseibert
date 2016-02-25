#!/bin/bash

BACKUP_DIR=/home/setter/backups
DATE=`date "+%Y-%m-%d___%H:%M:%S"`

mkdir -p $BACKUP_DIR
mkdir -p $BACKUP_DIR/images
mkdir -p $BACKUP_DIR/$DATE
mkdir -p $BACKUP_DIR/$DATE/mysql

rsync -r $SETTER_IMAGES_DIR $BACKUP_DIR/images

mysqldump -u root -p$SETTER_DB_PASS setter > $BACKUP_DIR/$DATE/mysql/setter_$DATE.sql
