#!/bin/bash
# expample: sudo ./deploy.sh username

if [ ! $1 ]; then
    USR=titovanton
else
    USR=$1
fi

chown -R $USR:www-data %PROJECT_DIR%
chown -R $USR:www-data %STATIC%
chown -R $USR:www-data %MEDIA%
chown -R $USR:www-data %INTERNAL%
chmod -R 771 %PROJECT_DIR%
chmod -R 775 %STATIC%
chmod -R 775 %MEDIA%
chmod -R 775 %INTERNAL%
touch reload_uwsgi
service nginx --full-restart
