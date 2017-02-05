# concerto-docker-build
building concerto-platform in docker

## Installtion Guide
Install docker https://docs.docker.com/engine/installation/

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
