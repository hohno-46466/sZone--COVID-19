#!/bin/sh

# Last update: Sat Apr 23 09:43:02 JST 2022

cat "$@" \
| egrep '^20[0-9][0-9]-[0-1][0-9]-[0-3][0-9]' \
| awk -F'\t' ' {
	x=0;y=0;z=0;
	if(($2-$3)==p){x=1}
	if(($2-$4)==$5){y=1}
	if(($6+$7+$8)==$5){z=1}
	printf "%d %d %d %s ",x,y,z,$1
	printf "%d-%d %s %d | ",$2,p,(x==1)?"=":"!=",$3
	printf "%d-%d %s %d | ",$2,$4,(y==1)?"=":"!=",$5
	printf "%d %s %d+%d+%d",$5,(z==1)?"=":"!=",$6,$7,$8
	printf " | %s", $10
	printf "\n"
	p=$2
}'
