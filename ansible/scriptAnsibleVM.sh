#!/bin/bash

#1st VM Debian for Ansible
#This script must be executed after scriptWazuhVM.sh is executed on the remote server

#Install Ansible

#Install required dependencies
apt-get update
apt-get install lsb-release software-properties-common

#Setup ansible repository
echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" | sudo tee -a /etc/apt/sources.list.d/ansible-debian.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
apt-get update

#Install ansible
apt-get install ansible

#Ask for credentials
read -p 'Enter your username: ' your_username
read -p 'Ip Address: ' your_ipaddr

#Generate an authentication key pair for SSH
ssh-keygen

#Permissions settings
chmod 700 ~/.ssh/

#Install openssh-server
apt-get install openssh-server

#Start SSH service
systemctl start sshd

#Send ssh key to the wazuh server
cat ~/.ssh/id_rsa.pub | ssh ${your_username}@${your_ipaddr} "cat >> ~/.ssh/authorized_keys"

#Edit hosts file
sed -i ''${your_ipaddr}'ansible_ssh_user='${your_username}/'' /etc/ansible/hosts

#Clone wazuh-ansible repository
cd /etc/ansible/roles/
sudo git clone --branch v4.4.4 https://github.com/wazuh/wazuh-ansible.git


#Install Wazuh Indexer and Dashboard

#Create the file wazuh-indexer-and-dashboard.yml in the playbooks directory
cd /etc/ansible/roles/wazuh-ansible/
touch playbooks/wazuh-indexer-and-dashboard.yml

#Fill it with indexer and dashboard playbooks scripts
sed -i '- hosts: all_in_one
  roles:
    - role: ../roles/wazuh/wazuh-indexer
      perform_installation: false
  become: no
  vars:
    indexer_node_master: true
    instances:
      node1:
        name: node-1       # Important: must be equal to indexer_node_name.
        ip: 127.0.0.1
        role: indexer
  tags:
    - generate-certs

- hosts: all_in_one
  become: yes
  become_user: root
  roles:
    - role: ../roles/wazuh/wazuh-indexer
    - role: ../roles/wazuh/wazuh-dashboard

  vars:
    single_node: true
    indexer_network_host: 127.0.0.1
    ansible_shell_allow_world_readable_temp: true
    instances:           # A certificate will be generated for every node using the name as CN.
      node1:
        name: node-1
        ip: 127.0.0.1
        role: indexer' ./playbooks/wazuh-indexer-and-dashboard.yml

#Run the playbook
ansible-playbook wazuh-indexer-and-dashboard.yml -b -K


#Install wazuh manager

#Access wazuh-ansible directory
cd /etc/ansible/roles/wazuh-ansible/

#We install it in all_in_one so we have to modify the host in the manager playbook
sed -i '0,/- hosts:*;/s//- hosts: all_in_one' ./playbooks/wazuh-manager-oss.yml

#Run the playbook
ansible-playbook wazuh-manager-oss.yml -b -K
