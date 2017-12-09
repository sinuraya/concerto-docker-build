FROM ubuntu:16.04

### select version with git commit
ARG CONCERTO_COMMIT=default
ENV CONCERTO_COMMIT ${CONCERTO_COMMIT}
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

