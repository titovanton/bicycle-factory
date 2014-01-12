# Bicycle Factory

## Overview

This repo contain standart [virtualenvwrapper](http://virtualenvwrapper.readthedocs.org/en/latest/ "virtualenvwrapper") hooks with custom shall scripts in following files:

* `premkvirtualenv`
* `postmkvirtualenv`
* `prermvirtualenv`

Also, it contain custom templates for setting up:

* [NGINX and UWSIG](https://uwsgi.readthedocs.org/en/latest/tutorials/Django_and_nginx.html "NGINX and UWSIG")
* [Twitter Bootstrap](http://getbootstrap.com/ "Twitter Bootstrap") integration
* robots.txt
* and so on...

It contain [Django project template](https://docs.djangoproject.com/en/1.6/ref/django-admin/#startproject-projectname-destination "Django project template"), made [by example](https://github.com/django/django/tree/master/django/conf/project_template/ "by example").

So, if you made virtual env using mkvirtualenv alias, be sure you have setting up NGINX(as proxy) and UWSGI(Imperor mode) config files, ready to runserver Django project (I use [Werkzeug](http://werkzeug.pocoo.org/ "Werkzeug"), so you can use runserver_plus managment command) with home view, Twitter Bootstrap markup(base.html, home.html) and Less styles(bootstrap.less, variables.less, my_main.less, my_mixins.less...).

## Catalogs Tree:

    **/** - root dir
     |
     +-- **webapps/** - web applications dir
          |
          +-- **envs/** - virtual envs dir
          |
          +-- **server/** - NGINX and UWSGI cofig files dir
          |
          +-- **django/** - Django projects dir

## Install First!

On virgine Ubuntu Linux you should install following packeges:

1. python2.7-dev and pip:
    sudo apt-get install python2.7-dev
    sudo apt-get install python-pip
    sudo pip install --upgrade pip
2. virtualenv and virtualenvwrapper:
    sudo pip install virtualenv
    sudo pip install virtualenvwrapper
    export WORKON_HOME=/webapps/envs
    sudo mkdir -p $WORKON_HOME
    sudo chown -R $USER:www-data $WORKON_HOME
    source /usr/local/bin/virtualenvwrapper.sh
    echo "export WORKON_HOME=$WORKON_HOME" >> ~/.bashrc
    echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
3. NGINX and UWSGI:
    sudo apt-get install nginx git
    pip install uwsgi
4. PostgreSQL, python bindings and so on:
    sudo apt-get install curl build-essential openssl libssl-dev python-psycopg2
    sudo apt-get install postgresql postgresql-client
    sudo apt-get install postgresql-server-dev-9.1
5. Image librarie:
    sudo apt-get install imagemagick
6. Less on Node js:
    git clone https://github.com/joyent/node.git $HOME/src/node
    cd $HOME/src/node
    ./configure
    make
    sudo make install
    node -v

    curl http://npmjs.org/install.sh | sudo sh
    npm -v
    npm install less

    echo "PATH=$PATH:$HOME/src/node/node_modules/less/bin" >> $HOME/.bashrc
