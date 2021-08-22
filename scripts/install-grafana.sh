#!/bin/bash
## Link para documentação do Grafana https://grafana.com/docs/grafana/latest/installation/docker/
## Instalação do docker Grafana
docker run -d -p 3000:3000 --name grafana grafana/grafana:8.1.0