#!/bin/bash
# expample: sudo ./deploy.sh username

if [ ! $1 ]; then
    USR=titovanton
else
    USR=$1
fi

%PROJECT_DIR%/manage.py glue
%PROJECT_DIR%/manage.py assets build
%PROJECT_DIR%/manage.py collectstatic

sudo chown -R $USR:www-data %PROJECT_DIR%
sudo chown -R $USR:www-data %STATIC%
sudo chown -R $USR:www-data %MEDIA%
sudo chown -R $USR:www-data %INTERNAL%
sudo chmod -R 771 %PROJECT_DIR%
sudo chmod -R 775 %STATIC%
sudo chmod -R 775 %MEDIA%
sudo chmod -R 775 %INTERNAL%
sudo touch reload_uwsgi
sudo service nginx --full-restart
