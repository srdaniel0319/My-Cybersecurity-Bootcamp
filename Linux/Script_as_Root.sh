#!/bin/bash

#Check if script was run as root. Exit if true.
if  [ $UID -eq 0 ]
then
	echo "do not run this script as root."
	exit
fi


#Define variables

output=$HOME/research/sys_info.txt

ip=$(ip addr | grep inet | tail -2 | head -1)

execs=$(sudo find /home -type f -perm 777)


#Check for research directory. Create it if needed.

if [ ! -d $HOME/research ]

then
	mkdir $HOME/research"

fi

#Check for output file. CLear it if needed.


if [ -f $output ]

then

	rm $output

fi


#############################################################
#Start Script


echo "A Quick System Audit Script" >> $output
date >> $output

echo "" >> $output

echo "Machine Type Info:" >> $output

echo -e "$MACHTYPE \n" >> $output

echo -e "Uname info: $(uname -a) \n" >> $output

echo -e "IP Info: " >> $output

echo -e "$ip \n" >> $output

echo -e "Hostname: $(hostname -s) \n" >> $output

echo "DNS Servers: " >> $output

cat /etc/resolv.conf >> $output

echo -e "\nMemory Info:" >> $output

free -h >> $output

echo -e "\nCPU Info:" >> $output

lscpu | grep CPU >> $output

echo -e "\nDisk Usage:" >> $output

df -H | head -2 >> $output

echo -e "\nWho is logged in: \n $(who) \n" >> $output

echo -e "\nExec Files:" >> $output

echo $execs >> $output

sudo find /home -type f -perm 777 >> $output

echo -e "\nTop 10 Processes" >> $output

ps aux -sort -%mem | awk {'print $1, $2, $3, $4, $11'} | head >> $output


#Condition

if [ -d ~/research ]

then "Research already exists"

else  "mkdir -p ~/research"

fi

