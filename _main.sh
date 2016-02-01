#!/bin/bash

# MENU
PS3='Please enter your choice: '
CREATE_OPT='Create Django project from project_template dir'
PULL_OPT='Pull Django project from remote git repo'
QUIT_OPT='Quit: let the environment be empty'
options=("$CREATE_OPT" "$PULL_OPT" "$QUIT_OPT")

printf '\nVirtual environment has been created successfully!\n'
printf 'You have to decide what we gonna do next:\n'

IS_CREATE=false
IS_PULL=false
select opt in "${options[@]}"
do
    case $opt in
        "$CREATE_OPT") IS_CREATE=true ;;
        "$PULL_OPT"  ) IS_PULL=true ;;
        "$QUIT_OPT"  ) exit 0 ;;
        *            ) echo invalid option ;;
    esac
    break
done


#############
# CONFIGURE #
#############

source $WORKON_HOME/_config.sh

# Create dirs
mkdir -p $PROJECT_DIR
mkdir -p $SERVER
mkdir -p $LOG/supervisor
mkdir -p $LOG/nginx
mkdir -p $STATIC
mkdir -p $STATIC/sprites
mkdir -p $MEDIA
mkdir -p $INTERNAL
mkdir $VIRTUAL_ENV/src

sudo echo 'Enter sudo passwrod please:'

# DB password
read -s -p "Enter PostgreSQL password (default: auto)? " DB_PWD
echo
if [[ $DB_PWD == '' ]]; then
    DB_PWD=$(cat /dev/urandom | tr -cd 'a-f0-9' | head -c 32)
fi

# Redis db number(name):
REDIS_DB=$(python $TEMPLATES/redis_db.py $WORKON_HOME/redis_index.json $PROJECT_NAME)
read -s -p "Enter Redis passwrod please: " REDIS_PWD
echo

# git
cd $PROJECT_DIR
git init
if $IS_CREATE; then
    source $WORKON_HOME/_make_config.sh
else
    read -p "Enter git repo please: " GIT_REMOTE
    echo

    # Pull Django project
    git remote add origin $GIT_REMOTE
    git pull origin master
    git submodule init
    git submodule update

    source $CONFIG
fi
git config --global user.name $GIT_USER
git config --global user.email $GIT_EMAIL
git config --global color.ui true

pip install --upgrade pip

pip install Django

if $IS_CREATE; then

    # Start Django project
    django-admin.py startproject --template=$PROJECT_TEMPLATE --extension=py,txt,less $PROJECT_NAME .
    sed -e "s;%DB_PWD%;$DB_PWD;g" \
        -e "s;%REDIS_DB%;$REDIS_DB;g" \
        -e "s;%REDIS_PWD%;$REDIS_PWD;g" \
        -i $PROJECT_DIR/$SETTINGS/secret.py

    # twitter bootstrap as git submodule
    if $TW_BOOTSTRAP; then
        git submodule add https://github.com/twbs/bootstrap.git $LIBS/bootstrap

        # integration
        cat $TEMPLATES/bs_header.less >> $STATIC_SRC/less/bootstrap.less
        cat $LIBS/bootstrap/less/bootstrap.less \
            | grep @import \
            | grep -v variables \
            | sed -e "s;@import \";@import \"$BOOTSTRAP_SED;g" \
            >> $STATIC_SRC/less/bootstrap.less
        cat $TEMPLATES/bs_footer.less >> $STATIC_SRC/less/bootstrap.less
        cp $LIBS/bootstrap/less/variables.less $STATIC_SRC/less/
    fi

    # # bicycle as git submodule
    # if $BICYCLE; then
    #     git submodule add $BICYCLE_URL bicycle
    # fi

    # jquery-ui-carousel as git submodule
    if $JS_CAROUSEL; then
        git submodule add https://github.com/richardscarrott/jquery-ui-carousel.git \
            $LIBS/jquery-ui-carousel
    fi

    # fancyBox as git submodule
    if $FANCYBOX; then
        git submodule add https://github.com/fancyapps/fancyBox.git \
            $LIBS/fancyapps-fancyBox
    fi

    # print as git submodule
    if $JS_PRINT; then
        git submodule add https://github.com/posabsolute/jQuery-printPage-plugin.git \
            $LIBS/jQuery-printPage-plugin
    fi

    # first commit
    cp $TEMPLATES/.gitignore ./
    git add README.md
    git add addon
    git add $MAINAPP
    git add dashboard.py
    git add .gitignore
    git add .gitmodules
    git add requirements.pip
    git add deploy.sh
    git commit -m 'first commit'
fi
if $IS_PULL; then
    cp $PROJECT_TEMPLATE/manage.py ./
    cp $PROJECT_TEMPLATE/$MAINAPP/wsgi.py $MAINAPP/
    SECRET_KEY=$(cat /dev/urandom | tr -cd 'a-f0-9~!@#$%^&*()_+<>?:,.\|-' | head -c 50)
    sed -e "s;%DB_PWD%;$DB_PWD;g" \
        -e "s;%REDIS_DB%;$REDIS_DB;g" \
        -e "s;%REDIS_PWD%;$REDIS_PWD;g" \
        -e "s;{{ secret_key }};$SECRET_KEY;g" \
        -e "s;{{ project_name }};$PROJECT_NAME;g" \
        $PROJECT_TEMPLATE/$SETTINGS/secret.py > $PROJECT_DIR/$SETTINGS/secret.py
fi


######
# DB #
######

if [ ! -f $HOME/.pgpass ]; then
    printf '\nYou can touch .pgpass file with chmode 0600 in your home dir\n'
    printf "insted prompt password for user $PG_SU every time.\n"
    printf 'Read the man: http://www.postgresql.org/docs/9.0/static/libpq-pgpass.html\n\n'
fi

read -p "Enter PostgreSQL superuser (default: postgres)? " PG_SU
if [[ $PG_SU == '' ]]; then
    PG_SU=postgres
fi
read -p "Enter DB host (default: localhost)? " PG_HOST
if [[ $PG_HOST == '' ]]; then
    PG_HOST=localhost
fi

# Create DataBase
psql -h $PG_HOST -U $PG_SU -f $TEMPLATES/createdb.sql -v passwd=\'$DB_PWD\' -v user=$PROJECT_NAME


##########
# FINISH #
##########

# pip packages
pip install -U -r $PIP_PACKAGES

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
    -e "s;%LOG%;$LOG;g" \
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
    -e "s;%PROJECT_NAME%;$PROJECT_NAME;g" \
    -e "s;%STATIC%;$STATIC;g" \
    -e "s;%LOG%;$LOG;g" \
    -e "s;%MEDIA%;$MEDIA;g" \
    -e "s;%INTERNAL%;$INTERNAL;g" \
    -e "s;%DUMMY_ROOT%;$DUMMY_ROOT;g" \
    $TEMPLATES/deploy.sh > $PROJECT_DIR/deploy.sh
sudo chmod +x $PROJECT_DIR/deploy.sh

# robots and favicon
# sed -e "s;%PROJECT_NAME%;$PROJECT_NAME;g" -i $STATIC/robots.txt

# permissions
sudo chown -R $UNIX_USER:www-data $VIRTUAL_ENV
sudo chown -R $UNIX_USER:www-data $PROJECT_DIR
sudo chown -R $UNIX_USER:www-data $SERVER
sudo chown -R $UNIX_USER:www-data $LOG

rm $WORKON_HOME/name
