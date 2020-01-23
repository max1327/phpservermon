FROM mylesp/dockerlamp

RUN apt update && apt install curl wget && apt clean && rm -rf /var/lib/apt/lists/*
RUN /usr/sbin/a2dismod 'mpm_*' && /usr/sbin/a2enmod mpm_prefork


CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
EXPOSE 443

ENV VERSION 3.2.0
ENV PHPMONITOR_URL https://sourceforge.net/projects/phpservermon/files/latest/download

RUN set -x \
 	&& cd /var/www/html \
	&& rm -rf * \
	&& cd /tmp \
	&& wget $PHPMONITOR_URL \ 
	&& mv download phpmonitor.tar.gz \
	&& tar -xvf phpmonitor.tar.gz --strip-components=1 \
	&& cd phpservermon-3.2.0 \
	&& mv * /var/www/html \ 
	&& cd /var/www/html \
	&& touch config.php \
	&& chmod 0777 config.php
