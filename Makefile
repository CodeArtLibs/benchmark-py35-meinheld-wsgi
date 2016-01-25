IP=`boot2docker ip`
CONTAINER_ID=`docker ps -q`

# Native

bootstrap:
	virtualenv env -p python
	env/bin/pip install -r requirements.txt

deps:
	env/bin/pip install -r requirements.txt

start:
	supervisord -l /tmp/supervisord.log -y 100KB -z 0 -e info -j /tmp/supervisord.pid

status:
	supervisorctl status

log:
	tail -f /tmp/supervisord.log
	tail -f /tmp/app_server.log

stop:
	supervisorctl stop
	supervisorctl shutdown

# Docker -> Native

build:
	docker build --tag codeart-benchmarks/benchmark-py27-bjoern-wsgi:v1 .
	docker images

browser:
	open "http://${IP}:8001"

run: browser
	docker run -i -p 8001:8000 -e WORKERS=5 -e KEEP_ALIVE=120 -e PORT=8000 codeart-benchmarks/benchmark-py27-bjoern-wsgi:v1
	docker ps -l

dstatus:
	docker exec ${CONTAINER_ID} supervisorctl status

port:
	docker port ${CONTAINER_ID}

ps:
	boot2docker ip
	docker ps
