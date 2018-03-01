# Ganglia docker

## Demos
![](asserts/ganglia_demo.gif)

## Requisites
- docker
- docker-compose
- Linux
- check if the firewall is disable on your machine

## Usage
### clone project and build docker image
```
git clone https://github.com/dockerq/docker-ganglia.git
cd docker-ganglia
docker build -t dockerq/ganglia . (you can use someone else image name)
```
### change docker-compose.yml file
cat docker-compose.yml
```
ganglia:
    image: dockerq/ganglia(the image name you build)
    privileged: true
    ipc: host
    net: host
    pid: host
    container_name: ganglia
    ports:
        - 9090:80
    volumes:
        - /sys:/sys
        - /dev:/dev
```

### config ganglia
configure files are in directory `conf`

### run
```
cd ganglia
docker-compose up -d
```

## Troubleshooting
I run `docker-compose up -d` in my pc,(ubuntu 14.04 docker 1.9.1) and I run into the following error:

```
  ERROR: Cannot start container 84d255960b938a53d168f9fe5ebc3940568d508f3a85cc6a4190f326d5252725: /dev/mqueue is not mounted, but must be for --ipc=host
```

first I run `ls -al /dev | grep mqueue` to see if the dir exists:

```
geek@prod:ganglia$ ls -al /dev | grep mqueue
geek@prod:ganglia$
```

This indicates `/dev/mqueue` does not exist. So I take the following action:

```
geek@prod:ganglia$ sudo mkdir -p /dev/mqueue
```

and run `docker-compose up -d`,the container runs correctly
