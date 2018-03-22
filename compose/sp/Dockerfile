FROM tecnickcom/php-saml

ADD ./php/acs.php /var/www/html/php-saml/demo2/
ADD ./php/settings.php ./php/advanced_settings.php /var/www/html/php-saml/

CMD rm -f /run/apache2/apache2.pid; /usr/sbin/apache2ctl -D FOREGROUND
