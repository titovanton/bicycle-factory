#!/bin/bash

source $WORKON_HOME/_core.cfg.sh

# PostgreSQL
read -p "Enter PostgreSQL superuser (default: postgres)? " PG_SU
if [[ $PG_SU == '' ]]; then
    PG_SU=postgres
fi
read -p "Enter DB host (default: localhost)? " PG_HOST
if [[ $PG_HOST == '' ]]; then
    PG_HOST=localhost
fi

# Unix user
read -p "Enter Unix user (default: $USER)? " UNIX_USER
if [[ $UNIX_USER == '' ]]; then
    UNIX_USER=$USER
fi

# Git
read -p "Enter Git user (default: titovanton)? " GIT_USER
if [[ $GIT_USER == '' ]]; then
    GIT_USER=titovanton
fi
read -p "Enter your Email (default: mail@titovanton.com)? " GIT_EMAIL
if [[ $GIT_EMAIL == '' ]]; then
    GIT_EMAIL=mail@titovanton.com
fi

# Bootstrap
read -p "Git submodule: twitter bootstrap (yes/no, default: yes)? " TW_BOOTSTRAP
if [[ $TW_BOOTSTRAP == 'no' || $TW_BOOTSTRAP == 'n' ]]; then
    TW_BOOTSTRAP=false
fi
if [[ $TW_BOOTSTRAP == 'yes' || $TW_BOOTSTRAP == 'y' || $TW_BOOTSTRAP == '' ]]; then
    TW_BOOTSTRAP=true
fi

# bicycle
read -p "Git submodule: bicycle (yes/no, default: yes)? " BICYCLE
if [[ $BICYCLE == 'no' || $BICYCLE == 'n' ]]; then
    BICYCLE=false
fi
if [[ $BICYCLE == 'yes' || $BICYCLE == 'y' || $BICYCLE == '' ]]; then
    BICYCLE=true
    read -p "Git submodule: pull method (git/https, default: git)? " BICYCLE_URL
    if [[ $BICYCLE_URL == 'https' ]]; then
        BICYCLE_URL=https://github.com/titovanton/bicycle-submodule.git
    fi
    if [[ $BICYCLE_URL == 'git' || $BICYCLE_URL == '' ]]; then
        BICYCLE_URL=git@github.com:titovanton/bicycle-submodule.git
    fi
fi

# rc-carousel
read -p "Git submodule: rc-carousel (yes/no, default: no)? " JS_CAROUSEL
if [[ $JS_CAROUSEL == 'no' || $JS_CAROUSEL == 'n' || $JS_CAROUSEL == '' ]]; then
    JS_CAROUSEL=false
fi
if [[ $JS_CAROUSEL == 'yes' || $JS_CAROUSEL == 'y' ]]; then
    JS_CAROUSEL=true
fi

# Fancybox
read -p "Git submodule: Fancybox (yes/no, default: no)? " FANCYBOX
if [[ $FANCYBOX == 'no' || $FANCYBOX == 'n' || $FANCYBOX == '' ]]; then
    FANCYBOX=false
fi
if [[ $FANCYBOX == 'yes' || $FANCYBOX == 'y' ]]; then
    FANCYBOX=true
fi

# js-print
read -p "Git submodule: js-print (yes/no, default: no)? " JS_PRINT
if [[ $JS_PRINT == 'no' || $JS_PRINT == 'n' || $JS_PRINT == '' ]]; then
    JS_PRINT=false
fi
if [[ $JS_PRINT == 'yes' || $JS_PRINT == 'y' ]]; then
    JS_PRINT=true
fi


echo "#!/bin/bash\n" > $CONFIG_FILE
echo "PG_SU=$PG_SU" >> $CONFIG_FILE
echo "PG_HOST=$PG_HOST" >> $CONFIG_FILE
echo "UNIX_USER=$UNIX_USER" >> $CONFIG_FILE
echo "GIT_USER=$GIT_USER" >> $CONFIG_FILE
echo "GIT_EMAIL=$GIT_EMAIL" >> $CONFIG_FILE
echo "TW_BOOTSTRAP=$TW_BOOTSTRAP" >> $CONFIG_FILE
echo "BICYCLE=$BICYCLE" >> $CONFIG_FILE
echo "BICYCLE_URL=$BICYCLE_URL" >> $CONFIG_FILE
echo "JS_CAROUSEL=$JS_CAROUSEL" >> $CONFIG_FILE
echo "FANCYBOX=$FANCYBOX" >> $CONFIG_FILE
echo "JS_PRINT=$JS_PRINT" >> $CONFIG_FILE


# pip
cp $TEMPLATES/packages.pip $PIP_PACKAGES

# Wand
read -p "Pip packages: Wand (yes/no, default: no)? " ANSWER
if [[ $ANSWER == 'yes' || $ANSWER == 'y' ]]; then
    echo 'Wand' >> $PIP_PACKAGES
fi

# requests
read -p "Pip packages: requests - needs for search2(yes/no, default: no)? " ANSWER
if [[ $ANSWER == 'yes' || $ANSWER == 'y' ]]; then
    echo 'requests' >> $PIP_PACKAGES
fi

# django-bootstrap3
read -p "Pip packages: django-bootstrap3(yes/no, default: no)? " ANSWER
if [[ $ANSWER == 'yes' || $ANSWER == 'y' ]]; then
    echo 'django-bootstrap3' >> $PIP_PACKAGES
fi

# qrcode
read -p "Pip packages: qrcode(yes/no, default: no)? " ANSWER
if [[ $ANSWER == 'yes' || $ANSWER == 'y' ]]; then
    echo 'qrcode' >> $PIP_PACKAGES
fi

# django_rq
read -p "Pip packages: django_rq(yes/no, default: no)? " ANSWER
if [[ $ANSWER == 'yes' || $ANSWER == 'y' ]]; then
    echo 'django_rq' >> $PIP_PACKAGES
fi

# django-modeltranslation
read -p "Pip packages: django-modeltranslation(yes/no, default: no)? " ANSWER
if [[ $ANSWER == 'yes' || $ANSWER == 'y' ]]; then
    echo 'django-modeltranslation' >> $PIP_PACKAGES
fi

# django-recaptcha
read -p "Pip packages: django-recaptcha(yes/no, default: no)? " ANSWER
if [[ $ANSWER == 'yes' || $ANSWER == 'y' ]]; then
    echo 'django-recaptcha' >> $PIP_PACKAGES
fi

# git+git://github.com/toastdriven/django-tastypie.git
read -p "Pip packages: django-tastypie(yes/no, default: no)? " ANSWER
if [[ $ANSWER == 'yes' || $ANSWER == 'y' ]]; then
    echo 'django-tastypie' >> $PIP_PACKAGES
fi
