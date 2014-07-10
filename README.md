# Bicycle Factory

## Overview

This list of bush scripts provides to create Django project with all python applications they depend, on your Ubuntu, or pull code from git repo to help deploy website.

This repo contain standart [virtualenvwrapper](http://virtualenvwrapper.readthedocs.org/en/latest/ "virtualenvwrapper") hooks with custom shall scripts in following files:

* `premkvirtualenv`
* `postmkvirtualenv`
* `prermvirtualenv`

Also, it contain custom templates for setting up:

* [nginx and uWSGI](https://uwsgi.readthedocs.org/en/latest/tutorials/Django_and_nginx.html "nginx and uWSGI")
* [Twitter Bootstrap](http://getbootstrap.com/ "Twitter Bootstrap") integration
* robots.txt
* and so on...

provide redis db index generation in case several websites on one host.

It contain [Django project template](https://docs.djangoproject.com/en/1.6/ref/django-admin/#startproject-projectname-destination "Django project template"), made [by example](https://github.com/django/django/tree/master/django/conf/project_template/ "by example").

So, if you made virtual environment using mkvirtualenv alias, be sure you have setting up 

* [NGINX(as proxy) and uWSGI(Emperor mode)](https://uwsgi.readthedocs.org/en/latest/tutorials/Django_and_nginx.html "NGINX(as proxy) and uWSGI(Emperor mode)")(just in case, read the manual) config files
* ready to runserver Django project (I use [Werkzeug](http://werkzeug.pocoo.org/ "Werkzeug"), so you can use runserver_plus managment command)
* with home view, Twitter Bootstrap markup(base.html, home.html)
* and Less styles(bootstrap.less, variables.less, my_main.less, my_mixins.less...).

## Usage

All you need is just make virtual environment via virtualenvwrapper:

    mkvirtualenv helloworld

and you will see the following dialog:

    Virtual environment has been created successfully!
    You have to decide what we gonna do next:
    1) Create Django project from project_template dir
    2) Pull Django project from remote git repo
    3) Quit: let the environment be empty
    Please enter your choice:

Sometimes, 3d line float to the right side of 1t line, I don't know how to fix it...

## Prepare

You should creat the following, for works properly:

    / - root dir
    └── webapps/ - web applications dir
        ├── envs/ - virtual environments dir
        ├── server/ - nginx and uWSGI config files dir
        └── django/ - Django projects dir
            ├── internal/ - description comes below
            ├── static/ - Django static files
            └── media/ - Django users loaded files

execute following commands:

    sudo mkdir -p /webapps/envs /webapps/server /webapps/django/internal /webapps/django/static /webapps/django/media 

Internal - read the doc: [Nginx internal](http://nginx.org/en/docs/http/ngx_http_core_module.html#internal "Nginx internal")([RU](http://nginx.org/ru/docs/http/ngx_http_core_module.html#internal "RU"))

Do not forget to set permissions:
    
    sudo chown -R $USER:www-data /webapps

## Install First!

On virgine Ubuntu Linux Server v14.04 LTS you should install following packeges:

0. Update and upgrade Ubuntu:

        sudo apt-get update; sudo apt-get upgrade -y

1. git, python2.7-dev and pip:

        sudo apt-get install -y git python2.7-dev python-pip libjpeg-dev
        sudo pip install --upgrade pip

2. virtualenv, virtualenvwrapper and bicycle-factory:

        sudo pip install virtualenv
        sudo pip install virtualenvwrapper
        export WORKON_HOME=/webapps/envs
        git clone https://github.com/titovanton-com/bicycle-factory.git $WORKON_HOME
        sudo chown -R $USER:www-data $WORKON_HOME
        source /usr/local/bin/virtualenvwrapper.sh
        echo "export WORKON_HOME=$WORKON_HOME" >> ~/.bashrc
        echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc

3. Iptables

    1) at local machine and jump to 3), else jump to 2):

        sudo cp /webapps/envs/templates/iptables_local.sh /etc/network/iptables_ruls.sh

    2) at production:

        sudo cp /webapps/envs/templates/iptables_production.sh /etc/network/iptables_ruls.sh

    3) launch and add to rc.local:

        sudo /etc/network/iptables_ruls.sh
        sudo sed -e "s;exit 0;/etc/network/iptables_ruls.sh\n\nexit 0;g" -i /etc/rc.local

4. nginx and uWSGI:

        sudo apt-get install nginx -y
        sudo pip install uwsgi

    To increase server_names_hash_bucket_size execute the following row:

        sudo sed -e "s/# server_names_hash_bucket_size 64/server_names_hash_bucket_size 64/g" \
                 -i /etc/nginx/nginx.conf

    Why? Becouse if you did not do it, you will can not write the follow in nginx config file:

        server_name example.com example.net forum.example.com example.org blog.example.com

    It is too much for defaults...

5. setting up uWSGI in Emperor mode:
        
        sudo mkdir -p /var/log/uwsgi
        sudo mkdir -p /etc/uwsgi/vassals
        sudo chown -R $USER:www-data /var/log/uwsgi
        sudo chmod -R 774 /var/log/uwsgi
        cp /webapps/envs/templates/uwsgi_params /webapps/server/
        sudo nano /etc/rc.local
        sudo sed -e "s;exit 0;/usr/local/bin/uwsgi --emperor /etc/uwsgi/vassals --uid www-data --gid www-data --daemonize /var/log/uwsgi/mylog.log\n\nexit 0;g" -i /etc/rc.local

6. PostgreSQL, python bindings and so on:

        sudo apt-get install -y curl build-essential openssl libssl-dev python-psycopg2 postgresql postgresql-client postgresql-server-dev-9.3

7. Set password for postgres user (like root in MySQL):

        sudo -u postgres psql postgres

    and launch the command:

        \password postgres

    you will see password request (twice) - give it to him and then quit:

        \q

    Following to:

        sudo nano /etc/postgresql/9.3/main/pg_hba.conf 

    make sure to add it right after the "Put your actual configuration here" comment block! Otherwise one of the default entries might catch first and the databse authentication will fail.
        
        local   all             all                                     password

    Now you can login using psql client without specifying `-h localhost`:
        
        psql -U <user> <db>

## Optional

If you use SSH connection when interactiong with GitHub(Bitbucket), you will need to generate SSH Key:

1. SSH Keys

    Check the directory listing to see if you have files named either id_rsa.pub or id_dsa.pub.
    
        cd ~/.ssh
        ls -al

    If you already have it - add it on your hub account. Else:

        ssh-keygen -t rsa -C "your_email@example.com"

    and follow the quest... Then add your new key to the ssh-agent:

        # start the ssh-agent in the background
        eval `ssh-agent -s`
        ssh-add ~/.ssh/id_rsa

    Adding your SSH key to hub:

    - Copies the contents of the id_rsa.pub file to your clipboard
    - On GitHub follow the path: "Account settings" -> "SSH Keys" -> "Add key".
    - On Bitbucket follow the path: "Manage account" -> "SSH keys" -> "Add key".
    - Set name of record like named your server, to easy identify it in future.

You can save postgres and others users passwords in .pgpass for easy access to psql, but! It's fine if you do it on your local machine and it's not safe on production.

2. .pgpass for easy access to psql:

        # hostname:port:database:username:password
        echo '*:*:*:username:password' >> ~/.pgpass
        sudo chmod 600 ~/.pgpass


I also use following apps to serve needs of my websites:

3. [Redis](http://redis.io/ "Redis"):

        sudo apt-get install redis-server -y

    if you want change some settings, make a backup first:

        sudo cp /etc/redis/redis.conf /etc/redis/redis.conf.default

    for example, if you want to set password:

        sudo sed -e "s/# requirepass foobared/requirepass <password>/g" \
                 -i /etc/redis/redis.conf

4. [ElasticSearch](http://www.elasticsearch.org/ "ElasticSearch"):

        sudo apt-get install openjdk-7-jre-headless -y
        mkdir -p $HOME/src
        cd $HOME/src
        # v1.1.1 works fine for me:
        wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.1.deb
        sudo dpkg -i elasticsearch-1.1.1.deb
        # enable russian morphology support
        sudo /usr/share/elasticsearch/bin/plugin -install analysis-morphology -url http://dl.bintray.com/content/imotov/elasticsearch-plugins/org/elasticsearch/elasticsearch-analysis-morphology/1.2.0/elasticsearch-analysis-morphology-1.2.0.zip
        sudo update-rc.d elasticsearch defaults 95 10
        # bind only 127.0.0.1
        sudo sed -e "s/^# network\.host: .*$/network.host: 127.0.0.1/g" \
                 -i /etc/elasticsearch/elasticsearch.yml
        sudo service elasticsearch restart

5. Image librarie(if Pillow does not enough):

        sudo apt-get install imagemagick -y

6. Less:

        sudo apt-get install node-less -y

7. Cach:

    I use [memcached](http://memcached.org/ "memcached"), in this case:

        sudo apt-get install memcached -y

## Reboot

Reboot Ubuntu to launch uWSGI, ElasticSearch, reload PostgreSQL and checkout virtualenvwrapper works fine:
    
    sudo reboot

## How it damn thing really works?

The `postmkvirtualenv` file containt dialog menu that source a files with names starts with underscore:
    
* _config.sh
* _create.sh
* _finish.sh
* _prepare.sh
* _pull.sh

they do all work.

## Configure



## License
- Apache License, Version 2.0
- Download, install and use it where ever you want with my blessing =)
- PS: do not forget to give me a star!