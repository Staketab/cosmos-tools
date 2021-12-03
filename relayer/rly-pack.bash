#!/bin/bash

set -e

while true
do
	sleep 5
	$HOME/go/bin/rly tx relay-packets transfer
	$HOME/go/bin/rly tx relay-acknowledgements transfer
    sleep 25
done
