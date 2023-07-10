#!/bin/bash

# Requires NCFTP to be installed
# sudo apt-get install ncftp

#system settings
DIRS="/bin /etc /home /var/local /usr/local/bin /usr/lib /var/www"
BACKUP=/tmp/backup.$$
NOW=$(date +"%Y-%m-%d")
INCFILE="/root/tar-inc-backup.dat"
DAY=$(date +"%a")
FULLBACKUP="Mon"

#mysql settings
MUSER="root"
MPASS="yourpassword"
MHOST="localhost"
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
GZIP="$(which gzip)"

#ftp Settings 
FTPD="//backup-directory-on-ftp-server"
FTPU="ftp-username"
FTPP="ftp-password"
FTPS="ftp.server.address"
NCFTP="$(which ncftpput)"

#send email
EMAILID="youremail@yourdomain.com"

#backup our DPKG software list 
dpkg --get-selections > /etc/installed-software-dpkg.log

#Starting backup 
[ ! -d $BACKUP ] && mkdir -p $BACKUP || :

#select full or incremental backup 
if [ "$DAY" == "$FULLBACKUP" ]; then
  FTPD="//full-backups"
  FILE="MyServer-fs-full-$NOW.tar.gz"
  tar -zcvf $BACKUP/$FILE $DIRS
else
  i=$(date +"%Hh%Mm%Ss")
  FILE="MyServer-fs-incremental-$NOW-$i.tar.gz"
  tar -g $INCFILE -zcvf $BACKUP/$FILE $DIRS
fi

#mysql db backups 
#get all the mysql db names
DBS="$($MYSQL -u $MUSER -h $MHOST -p$MPASS -Bse 'show databases')"
for db in $DBS
do
 FILE=$BACKUP/mysql-$db.gz
 $MYSQLDUMP --single-transaction -u $MUSER -h $MHOST -p$MPASS $db | $GZIP -9 > $FILE
done

#check date for old files on FTP to delete
REMDATE=$(date --date="35 days ago" +%Y-%m-%d)

#perform ncftp backup 
ncftp -u"$FTPU" -p"$FTPP" $FTPS<<EOF
cd $FTPD
cd $REMDATE
rm -rf *.*
cd ..
rmdir $REMDATE
mkdir $FTPD
mkdir $FTPD/$NOW
cd $FTPD/$NOW
lcd $BACKUP
mput *
quit
EOF

#check if ftp backup failed
if [ "$?" == "0" ]; then
 rm -f $BACKUP/*
 mail  -s "MYSERVER - BACKUP SUCCESSFUL" "$EMAILID"
else
 T=/tmp/backup.fail
 echo "Date: $(date)">$T
 echo "Hostname: $(hostname)" >>$T
 echo "Backup failed" >>$T
 mail  -s "MYSERVER - BACKUP FAILED" "$EMAILID" <$T
 rm -f $T
fi