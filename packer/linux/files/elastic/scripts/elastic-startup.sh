#!/bin/bash

sudo sysctl -w vm.max_map_count=262144
sudo docker-compose -f create-cert.yml  run create_certs
sudo docker-compose up --force-recreate -d

