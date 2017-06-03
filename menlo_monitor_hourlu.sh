
#!/bin/sh
out="/var/log/menlotest.log"

# email settings Common
smtp="smtp.gmail.com:587"
fromadd="menlo2@cs.macnica.net"  # From email address
toadd="nohara-m@macnica.net,tamaki-ta@macnica.net,sasaki-ta@macnica.net"  # To email address (camma separated)

# Message in GOOD case
mtitleg="[AWS-1-OK!] :-) Menlo Monitor process is working Fine :-) "  # Email title
mbodyg="Healthy!" # Email body

# Message in BAD case
mtitleb="[AWS-1-要確認！] :-( Menlo Monitor process is NOT working :-( "  # Email title
mbodyb="The Monitoring proccess is NOT runnning! \n Please Access the monitoring machine on AWS and check process.\n If process is not running, execute: \"/home/ubuntu/menlo/menlotest.sh &\" " # Email body

# Process Check
pr=`ps -ef | grep "sh /home/ubuntu/menlo/menlotest.sh" -c`


 if [ $pr -eq 2 ]; then
   #/home/ubuntu/menlo/sendEmail-v1.56/sendEmail -o tls=yes -f $fromadd -t $toadd -s $smtp -xu menmac.mon@gmail.com -xp '!Menlo123' -u $mtitleg -m $mbodyg
   #/home/nohara/email/sendEmail-v1.56/sendEmail -f $fromadd -t $toadd -s $smtp -u $mtitleg -m $mbodyg
   echo `date` "[Monitor][INFO] menlotest.sh is running... " >> $out
 else
   /home/ubuntu/menlo/sendEmail-v1.56/sendEmail -o tls=yes -f $fromadd -t $toadd -s $smtp -xu menmac.mon@gmail.com -xp '!Menlo123' -u $mtitleb -m $mbodyb
   sh /home/ubuntu/menlo/slack_notify_cron.sh
   #/home/nohara/email/sendEmail-v1.56/sendEmail -f $fromadd -t $toadd -s $smtp -u $mtitleb -m $mbodyb
   echo `date` "[Monitor][ERROR] menlotest.sh is NOT running!!" >> $out
