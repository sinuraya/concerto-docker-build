FROM ubuntu:16.04

### select version with git commit
ARG CONCERTO_COMMIT=default
ENV CONCERTO_COMMIT ${CONCERTO_COMMIT}
### create database password
ARG CONCERTO_MYSQL_HOST=hello
ARG CONCERTO_MYSQL_DBNAME=hello
ARG CONCERTO_MYSQL_USER=hello
ARG CONCERTO_MYSQL_PASSWORD=hello
ENV MYSQL_HOST ${CONCERTO_MYSQL_HOST}
ENV MYSQL_DBNAME ${CONCERTO_MYSQL_DBNAME}
ENV MYSQL_USER ${CONCERTO_MYSQL_USER}
ENV MYSQL_PASSWORD ${CONCERTO_MYSQL_PASSWORD}
## copy tls folder
##COPY tls/ /tls
### install global packages
COPY install_deb.sh /
RUN /install_deb.sh


## install R packges
COPY Rdeb.R /
RUN Rscript Rdeb.R

## setup concerto
COPY concerto_setup.sh /
RUN /concerto_setup.sh

### run part
COPY concerto_run.sh /
CMD /concerto_run.sh
EXPOSE 80

