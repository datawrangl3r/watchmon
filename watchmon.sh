#!/bin/bash

for i in "$@"
do
case $i in
	-t=*|--threshold=*)
	thrs="${i#*=}"
	shift
	;;
	-e=*|--emails=*)
	emails="${i#*=}"
	shift
	;;
	"")
	echo -e "usage: watchmon [options]\n  options:\n   \
	       	-t, --threshold=    Threshold percentage of the Memory & Disk \n \
		-e, --emails=	    Email or Multiple Emails separated by commas"
	exit
        ;;
	*)
        echo -e "usage: watchmon [options]\n  options:\n   \
                -t=, --threshold=    Threshold percentage of the Memory & Disk \n \
                -e=, --emails=       Email or Multiple Emails separated by commas \n"
        exit
	;;
esac
done

if [[ $1 = '' ]]; then
	echo -e "usage: watchmon [options]\n  options:\n   \
	        -t=, --threshold=    Threshold percentage of the Memory & Disk \n \
	        -e=, --emails=       Email or Multiple Emails separated by commas \n"
	exit
fi

dskchk=0
memchk=0

freedsk=`df -h | grep ' /$' | awk '{print $5}' | sed 's/\%//g'`
freemem=`free -m | grep 'Mem' | awk '{printf "%.0f", $3*100/$2}'`

if [ "$freedsk" -gt "$thrs" ]; then
	dskmsg="Disk is not OK - ${freedsk} percentage utilized"
	dskchk=1
else
	dskmsg="Disk is OK"
fi

if [ "$freemem" -gt "$thrs" ]; then
	memmsg="Memory is not OK"
	memchk=1
else
	memmsg="Memory is OK"
fi

if [[ $memchk -gt 0 || $dskchk -gt 0 ]]; then
	message="$dskmsg, $memmsg"
	mutt -s "Attention - $HOSTNAME is in jeopardy - $message" emails < /dev/null
fi
