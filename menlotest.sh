#!/bin/sh
# Log
out="/var/log/menlotest.log"
echo `date` "[INFO] MenloHealthcheck started" >> $out

# Iteration Interval (sec)
i=300

# email settings
smtp="smtp.gmail.com:587"
fromadd="menlo2@cs.macnica.net"  # From email address
toadd="nohara-m@macnica.net,sasaki-ta@macnica.net,tamaki-ta@macnica.net"  # To email address (camma separated)
mtitle="[AWS-1][障害] Menlo Alert!"  # Email title
mbody="[AWS-1] No Expected Access was found in past 5 mins!!" # Email body

# Squid setting

filename=/home/ubuntu/menlo/squid3/access.log
output=/home/ubuntu/menlo/tail200_accesslog.txt

#fr=`date +%s` # Current time with unix format
#cnt=0 # counter
#freq=300 # monitoring threshold second

# output tmp file

#output=/home/ubuntu/menlo/tail200_accesslog.txt
#tail -200 $filename > $output

# Slack setting
#msg=`/home/ubuntu/menlo/slack_notify.sh`

# while do
while :
do

 fr=`date +%s` # Current time with unix format
 cnt=0 # counter
 #freq=300 # monitoring threshold second

 tail -200 $filename > $output

 while read line
 do

   aaa=`echo $line | awk -F' ' '{print $1}'`

   diff=`expr $fr - $aaa`

   if  [ $diff -lt 300  ]
   then
       if [ "`echo "$line" | grep "response.php"`" ] ; then
          echo ${line}
          echo $cnt
          cnt=`expr $cnt + 1`
       fi
   fi

 done < $output

# Email & Slack
 echo `date` "[INFO] Verified " $cnt " Logs in the past" $i "sec" >> $out

 if [ $cnt -lt 3 ]
   then
   /home/ubuntu/menlo/sendEmail-v1.56/sendEmail -o tls=yes -f $fromadd -t $toadd -s $smtp -xu menmac.mon@gmail.com -xp '!Menlo123' -u $mtitle -m $mbody -a /home/ubuntu/menlo/tail200_accesslog.txt
   sh /home/ubuntu/menlo/slack_notify.sh

 fi
 echo `date` "[INFO] Health check is finished. Proceeding another iteration." >> $out
 sleep $i

done
