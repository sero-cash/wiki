FROM nginx

MAINTAINER TomDurrent Sero

RUN rm /etc/nginx/conf.d/default.conf

ADD default.conf /etc/nginx/conf.d/

COPY ./  /usr/share/nginx/html/
