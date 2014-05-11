#!/bin/bash

source $WORKON_HOME/_config.sh

# requirements
pip install -r $PROJECT_DIR/requirements.pip

# setting up uwsgi.ini from template (imperor mode)
if [ ! -f $WEBAPPS/server/uwsgi_params ]; then
    cp $TEMPLATES/uwsgi_params $WEBAPPS/server/uwsgi_params
fi
echo 'touch this file to reload vassal' > $PROJECT_DIR/reload_uwsgi
sed -e "s;%PROJECT_DIR%;$PROJECT_DIR;g" \
    -e "s;%SERVER%;$SERVER;g" \
    -e "s;%VIRTUAL_ENV%;$VIRTUAL_ENV;g" \
    $TEMPLATES/uwsgi.ini > $SERVER/uwsgi.ini
sudo ln -s $SERVER/uwsgi.ini /etc/uwsgi/vassals/${PROJECT_NAME}.ini

# setting up nginx.conf from template
sed -e "s;%SERVER%;$SERVER;g" \
    -e "s;%PROJECT_NAME%;$PROJECT_NAME;g" \
    -e "s;%STATIC%;$STATIC;g" \
    -e "s;%MEDIA%;$MEDIA;g" \
    -e "s;%INTERNAL%;$INTERNAL;g" \
    -e "s;%UWSGI_PARAMS%;$UWSGI_PARAMS;g" \
    -e "s;%DUMMY_ROOT%;$DUMMY_ROOT;g" \
    $TEMPLATES/nginx.conf > $SERVER/nginx.conf
sudo ln -s $SERVER/nginx.conf /etc/nginx/sites-enabled/${PROJECT_NAME}.conf
sudo /etc/init.d/nginx restart

# deploy script
sed -e "s;%PROJECT_DIR%;$PROJECT_DIR;g" \
    -e "s;%STATIC%;$STATIC;g" \
    -e "s;%MEDIA%;$MEDIA;g" \
    -e "s;%INTERNAL%;$INTERNAL;g" \
    -e "s;%DUMMY_ROOT%;$DUMMY_ROOT;g" \
    $TEMPLATES/deploy.sh > $PROJECT_DIR/deploy.sh
sudo chmod +x $PROJECT_DIR/deploy.sh

# robots and favicon
cp $TEMPLATES/favicon.ico $STATIC
sed -e "s;%PROJECT_NAME%;$PROJECT_NAME;g" $TEMPLATES/robots.txt > $STATIC/robots.txt

# permissions
sudo chown -R $UNIX_USER:www-data $VIRTUAL_ENV
sudo chown -R $UNIX_USER:www-data $PROJECT_DIR
sudo chown -R $UNIX_USER:www-data $SERVER

rm $WORKON_HOME/name
