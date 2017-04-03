# concerto-docker-build
building concerto-platform in docker

## Installtion Guide
Install docker https://docs.docker.com/engine/installation/

you can either use the dockerhub image to just run concerto version  v5.0.beta.2.186
```sh
$ sudo docker run -d -it -p 80:80 hadyrashwan/concerto
```
or built  the latest and run it with the following 4 commands 
Clone the repo
```sh
$ git clone https://github.com/hadyrashwan/concerto-docker-build.git
```
enter the folder 
```sh
$ cd concerto-docker-build/
```
build your image
```sh
$ sudo docker build -t concerto .
```

run it 
```sh
$ sudo docker run -d -p 80:80 concerto
```
concerto should be running on port 80

## Options
 - define the commit hash for choosing concerto version
 - define mysql password
