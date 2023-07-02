#!/bin/bash

#OSSEC ruleset


#Ask for credentials
read -sp 'Enter your password: ' your_passwd
read -s 'Enter the email address where you want to receive the alerts: ' your_mail

sudo su
expect 'password: '
send "${your_passwd}/r"
cd ~

#LOG ANALYSIS

#Collecting log
sed -i '<localfile>
    <log_format>apache</log_format>
    <location>/var/log/apache/access.log</location>
</localfile>' /var/ossec/etc/ossec.conf

#Log analysis rules
sed -i '<rule id="100100" level="6">
    <if_sid>200000</if_sid>
    <regex>Invalid URI|SQL injection|Shell access</regex>
    <description>Apache intrusion attempt</description>
</rule>' /var/ossec/rules/local_rules.xml

#Logs can be viewed in the dashboard at the logs section


#FILE INTEGRITY CHECKING (UNIX & WINDOWS)

#Unix file integrity check
sed -i '<localfile>
    <log_format>syslog</log_format>
    <location>/etc/passwd</location>
</localfile>' /var/ossec/etc/ossec.conf

#Windows file integrity check
sed -i '<localfile>
    <log_format>windows</log_format>
    <location>C:\Windows\System32\drivers\etc\hosts</location>
</localfile>' /var/ossec/etc/ossec.conf

#Logs can be viewed in the dashboard at the alert section


#REGISTRY INTEGRITY CHECKING (WINDOWS)

#Registry integrity check
sed -i '<localfile>
    <log_format>windows</log_format>
    <registry>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run</registry>
</localfile>' /var/ossec/etc/ossec.conf


#HOST-BASED ANOMALY DETECTION (FOR UNIX - ROOTKIT DETECTION)

#Host anomaly detection
sed -i '<rootcheck>
    <disabled>no</disabled>
    <frequency>43200</frequency>
    <rootkit_files>/var/ossec/etc/shared/rootkit_files.txt</rootkit_files>
</rootcheck>' /var/ossec/etc/ossec.conf


#ACTIVE RESPONSE

#Blocking IP address after intrusion
sed -i '<active-response>
    <disabled>no</disabled>
    <command>iptables -I INPUT -s %srcip% -j DROP</command>
</active-response>' /var/ossec/etc/ossec.conf


#ALERTING

#Alert configuration
sed -i '<email_alerts>
    <email_to>'${your_mail}'</email_to>
    <group>sshd,</group>
    <do_not_delay/>
</email_alerts>' /var/ossec/etc/ossec.conf