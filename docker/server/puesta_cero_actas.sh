#!/usr/bin/env bash
NAME=tvs-reception
TALLIES="/opt/tvs/tallies"
SENDER="/opt/tvs/sender"
ZIP="/opt/tvs/devices"
echo "Start remove info tallies and send files"
echo "remove files in $TALLIES"
docker exec -it $NAME bash -c "rm -rf $TALLIES && mkdir $TALLIES"
echo "remove files in $SENDER"
docker exec -it $NAME bash -c "rm -rf $SENDER"
echo "remove files in $ZIP"
docker exec -it $NAME bash -c "rm -rf $ZIP"

