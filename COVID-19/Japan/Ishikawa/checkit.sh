#!/bin/sh

# Prev update: Sat Apr 23 09:43:02 JST 2022
# Last updated: Wed Apr 27 11:49:00 JST 2022 by @hohno_at_kuimc

cat "$@" \
| egrep '^20[0-9][0-9]-[0-1][0-9]-[0-3][0-9]' \
| awk -F'\t' ' {
	x=0;y=0;z=0;
	if(($2-$3)==p){x=1}
	if(($2-$4)==$5){y=1}
	if(($6+$7+$8)==$5){z=1}
	printf "%d %d %d %s ",x,y,z,$1

	if (x==0){
		printf "%d(=%d-%d) != %d" ,$3,$2,p,$2-p
	} else {
		printf "%d-%d=%d" ,$2,p,$2-p;
	}
	printf " | "

	if (y==0){
		printf "%d(=%d-%d) != %d",$5,$2,$4,$2-$4
	} else {
		printf "%d-%d=%d",$2,$4, $2-$4;
	}
	printf " | "

	if (z==0){
		printf "%d != %d(=%d+%d+%d)",$5,$6+$7+$8,$6,$7,$8
	} else {
		printf "%d=%d+%d+%d",$5,$6,$7,$8
        }
	printf " | %s", $10

	printf "\n"
	p=$2
}'
