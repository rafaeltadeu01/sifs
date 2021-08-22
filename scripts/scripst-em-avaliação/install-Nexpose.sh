#!/bin/bash

sudo docker pull whithajess/dockernexpose && \
sudo docker run \
  --name nexpose_container \
  -p 3780:3780 \
  -d whithajess/dockernexpose