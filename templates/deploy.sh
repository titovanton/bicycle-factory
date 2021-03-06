#!/bin/bash
# expample: sudo ./deploy.sh username

if [ ! $1 ]; then
    USR=titovanton
else
    USR=$1
fi

%PROJECT_DIR%/manage.py glue
%PROJECT_DIR%/manage.py assets build
%PROJECT_DIR%/manage.py collectstatic --noinput
%PROJECT_DIR%/manage.py compilemessages

# sudo cp %PROJECT_DIR%/addon/supervisor/rqworker.conf /etc/supervisor/conf.d/%PROJECT_NAME%_rqworker.conf
# mkdir -p %LOG%/supervisor/
# sudo supervisorctl reread
# sudo supervisorctl update

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
