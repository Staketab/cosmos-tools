#!/bin/bash
while true
do
	$HOME/go/bin/rly tx relay-packets transfer
	$HOME/go/bin/rly tx relay-acknowledgements transfer
    sleep 30
done
