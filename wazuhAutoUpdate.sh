#Wazuh auto update

#Create a directory to place the script
sudo mkdir -p /var/ossec/update/ruleset

#Download the script
sudo wget https://raw.githubusercontent.com/wazuh/ossec-rules/master/ossec_ruleset.py -O /var/ossec/update/ruleset/ossec_ruleset.py

#Assign it execution permission
sudo chmod u+x /var/ossec/update/ruleset/ossec_ruleset.py

#Update wazuh every week
sudo crontab -e
@weekly root cd /var/ossec/update/ruleset && ./ossec_ruleset.py -s