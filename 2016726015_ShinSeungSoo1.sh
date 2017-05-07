#!/bin/bash

export dimv
dimv=0
nd=`pwd | rev | cut -f 1 -d / | rev`
nc=`pwd`

info_print()
{
lnumber=`ls -l | grep -v total | wc -l`
i=1
k=0
	for i in `seq 1 ${lnumber}`
	do
	while [ $k -lt $dimv ]
	do
	echo -en "\t"
	k=`expr $k + 1`
	done
	k=0
	
	aaa=`ls -l | grep ^d | tr -s ' ' | sort -k 9 -t ' '`
	bbb=`ls -l | grep ^- | tr -s ' ' | sort -k 9 -t ' '`
	ccc=`ls -l | grep ^p | tr -s ' ' | sort -k 9 -t ' '`
	if [ "`ls -l | grep ^d | wc -l`" = "0" ]
	then
	element=`echo -e "$bbb\n$ccc" | tr -s ' ' | cut -f 9 -d ' ' | head -n $i | tail -n 1 `
	elif [ "`ls -l | grep ^- | wc -l`" = "0" ]
	then
	element=`echo -e "$aaa\n$ccc" | tr -s ' ' | cut -f 9 -d ' ' | head -n $i | tail -n 1 `
	elif [[ "`ls -l | grep ^d | wc -l`" = "0"&& "`ls -l | grep ^- | wc -l`" = "0" ]]
	then
	element=`echo -e "$ccc" | tr -s ' ' | cut -f 9 -d ' ' | head -n $i | tail -n 1`
	else
	element=`echo -e "$aaa\n$bbb\n$ccc" | tr -s ' ' | cut -f 9 -d ' ' | head -n $i | tail -n 1 `
	fi

#	element=`ls -l --g | grep -v ^total | tr -s ' ' | cut -f 9 -d ' ' | head -n $i | tail -n 1 `
		repa=`pwd $element`/$element
		tempn=${repa#$nc}
		realn=${tempn#'/'}
		echo "[$i] $realn"
	while [ $k -lt $dimv ]
	do
	echo -en "\t"
	k=`expr $k + 1`
	done
	k=0
		echo "=================INFORMATION=================="
	while [ $k -lt $dimv ]
	do
	echo -en "\t"
	k=`expr $k + 1`
	done
	k=0
		if [ "`file  $element | cut -f 2 -d ' ' | cut -c 1`" = "d" ]
		then
			echo [34m"file type : Dir "[0m
		elif [ "`file  $element | cut -f 2 -d ' ' | cut -c 1`" = "f" ]
		then
			echo [32m"file type : fifo  "[0m
		else
			echo "file type : Normal "
		fi

	while [ $k -lt $dimv ]
	do
	echo -en "\t"
	k=`expr $k + 1`
	done
	k=0
		echo "file size : `stat $element | head -n 2 | tail -n 1 | tr -s ' ' | cut -f 3 -d ' '`"
	while [ $k -lt $dimv ]
	do
	echo -en "\t"
	k=`expr $k + 1`
	done
	k=0
		echo "creation time : `stat $element | head -n 5 | tail -n 1 | cut -f 2-5 -d ' ' `"
	while [ $k -lt $dimv ]
	do
	echo -en "\t"
	k=`expr $k + 1`
	done
	k=0
		echo "permission : `stat $element | head -n 4 | tail -n 1 | cut -f 2 -d "(" | cut -c 2-4`"
	while [ $k -lt $dimv ]
	do
	echo -en "\t"
	k=`expr $k + 1`
	done
	k=0
		echo "absolite path : `pwd $element `/$element "
		repa=`pwd $element`/$element
	while [ $k -lt $dimv ]
	do
	echo -en "\t"
	k=`expr $k + 1`
	done
	k=0
		relpa=${repa#$nc}
		echo "relative path :./$nd$relpa"
	while [ $k -lt $dimv ]
	do
	echo -en "\t"
	k=`expr $k + 1`
	done
	k=0
		echo "=============================================="
		hihiho=`ls -l $element | wc -l`
		hohoho=2
		if [ $hihiho -ge $hohoho ]
		then
			dimv=`expr $dimv + 1`
			cd $element
			info_print
			cd ..
			dimv=`expr $dimv - 1`
		fi
	done
}



info_print
