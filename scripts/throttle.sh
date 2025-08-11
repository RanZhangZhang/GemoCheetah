#!/bin/bash
######
# Taken from https://github.com/emp-toolkit/emp-readme/blob/master/scripts/throttle.sh
######

## replace DEV=lo with your card (e.g., eth0)
DEV=lo 
if [ "$1" == "del" ]
then
	sudo tc qdisc del dev $DEV root
	echo Set Norm net
fi

if [ "$1" == "lan" ]
then
sudo tc qdisc del dev $DEV root
## about 1Gbps
sudo tc qdisc add dev $DEV root handle 1: tbf rate 1000mbit burst 100000 limit 10000
## about 0.3ms ping latency
sudo tc qdisc add dev $DEV parent 1:1 handle 10: netem delay 0.3msec
echo Set LAN
fi
if [ "$1" == "wan" ]
then
sudo tc qdisc del dev $DEV root
## about 100Mbps
sudo tc qdisc add dev $DEV root handle 1: tbf rate 100mbit burst 100000 limit 10000
## about 40ms ping latency
sudo tc qdisc add dev $DEV parent 1:1 handle 10: netem delay 40msec
echo Set WAN
fi
