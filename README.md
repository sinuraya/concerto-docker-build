# concerto-docker-build
building concerto-platform in docker

## Installtion Guide
Install docker https://docs.docker.com/engine/installation/

you can either use the dockerhub image to just run concerto
```sh
$ sudo docker run -d -it -p 80:80 hadyrashwan/concerto
```
or built it the latest and run it with the following 4 commands 
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
$ sudo docker build -f DOCKERFILE -t concerto 
```

run it 
```sh
$ sudo docker run -d -p 80:80 concerto
```
concerto should be running on port 80
