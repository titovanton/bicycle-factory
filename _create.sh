#!/bin/bash

source $WORKON_HOME/_config.sh
source $WORKON_HOME/_prepare.sh

cd $PROJECT_DIR

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

# bicycle as git submodule
if $BICYCLE; then
    git submodule add $BICYCLE_URL bicycle
fi

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
git commit -m 'first commit'

$WORKON_HOME/_finish.sh
