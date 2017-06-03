#!/bin/sh

# Iteration Intervals
i=30

while :
do
 firefox --safemode &
 echo `date` >> /home/ubuntu/menlo/firefox_log
 echo 'Firefox started' >> /home/ubuntu/menlo/firefox_log
 sleep $i
 killall -9 firefox
 echo `date` >> /home/ubuntu/menlo/firefox_log
 echo 'Firefox Terminated' >> /home/ubuntu/menlo/firefox_log
 sleep $i
done
