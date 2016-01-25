codeart-benchmark-toolset
=========================

Usage
-----

    make bootstrap
    make deps
    make start
    make status
    make log
    make stop


Usage with Docker
-----------------

Install Docker: https://docs.docker.com/mac/step_one/ or https://docs.docker.com/linux/step_one/

OSX Docker example:

    boot2docker init
    boot2docker start
    boot2docker ip
    export DOCKER_HOST=tcp://192.168.59.103:2376
    export DOCKER_CERT_PATH=/Users/paulocheque/.boot2docker/certs/boot2docker-vm
    export DOCKER_TLS_VERIFY=1

General:

    make build
    make browser
    make run
    make ps
