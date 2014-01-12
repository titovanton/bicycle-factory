sudo chown -R $USER:www-data %DJANGO%
sudo chmod -R 771 %DJANGO%
sudo chmod -R 775 %STATIC%
sudo chmod -R 775 %MEDIA%
sudo chmod -R 775 %INTERNAL%
sudo touch reload_uwsgi
sudo service nginx --full-restart