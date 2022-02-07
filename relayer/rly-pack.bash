#!/bin/bash

set -e

while true
do
	$HOME/go/bin/rly tx relay-packets ${PORT}
	sleep 6
	$HOME/go/bin/rly tx relay-acknowledgements ${PORT}
	sleep 3
done
