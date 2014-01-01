sudo apt-get install python2.7-dev
sudo apt-get install python-pip
sudo pip install --upgrade pip
sudo pip install virtualenv
sudo pip install virtualenvwrapper
export WORKON_HOME=/webapps/envs
sudo mkdir -p $WORKON_HOME
sudo chown -R titovanton:www-data $WORKON_HOME
source /usr/local/bin/virtualenvwrapper.sh
echo "export WORKON_HOME=$WORKON_HOME" >> ~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc

sudo apt-get install nginx git
pip install uwsgi
sudo apt-get install curl build-essential openssl libssl-dev python-psycopg2
sudo apt-get install postgresql postgresql-client
sudo apt-get install postgresql-server-dev-9.1

# sudo apt-get install imagemagick

# node + less
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
