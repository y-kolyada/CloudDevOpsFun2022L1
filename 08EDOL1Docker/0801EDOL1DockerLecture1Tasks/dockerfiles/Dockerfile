FROM ubuntu:20.04

ENV TZ=Europe/Kiev
RUN apt-get -y update
RUN DEBIAN_FRONTEND="noninteractive" \
  apt-get -y install apache2
RUN echo 'Hi there, what is love?' > /var/www/html/index.html
RUN echo 'It is just a song...' >> /var/www/html/index.html

CMD ["/usr/sbin/apache2ctl" ,"-DFOREGROUND"]

EXPOSE 80
