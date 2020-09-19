#!/bin/bash

set -x

echo "start deploy ${USER}"
GOOS=linux go build -o isucari
for server in isu01 ; do
  ssh -t $server "sudo systemctl stop isucari.golang.service"
  scp ./isucari $server:/home/isucon/isucari/webapp/go/isucari
  rsync -vau ../sql/ $server:/home/isucon/isucari/webapp/sql/
  ssh -t $server "sudo systemctl start isucari.golang.service"
done

echo "finish deploy ${USER}"
