## Installation du serveur Wazuh

Cette installation demande 2 machines au minimum pour fonctionner, une machine Ansible et un remote system ou sera installé Wazuh.
Le système d'éxploitation utilisé sur les VM est Debian.

‼️ Attention à ce que le nom de vos machines soit différents ‼️

Ce projet permet de configurer et d'utiliser Ansible comme outil d'automatisation pour déployer et configurer le système de détection d'intrusion Wazuh.

> Le lancement de ces scripts vous demandera l'adresse IP de vos différentes machines.
>
> Pour le bon fonctionnement veuillez passez en root avant d'exécuter les scripts avec la commande ``` su - ```.

Avant de vous lancer dans l'installation, veuillez télécharger Git sur vos deux machines
```
apt install git
apt update
```

Pour commencer il faut cloner le dossier Ansible sur le host ansible depuis le GitHub du projet.
```
sudo git clone https://github.com/LeGrandDevin/WAZUH-GRP3-ANSIBLE
```
Puis il faut cloner le dossier Wazuh sur le remote system.
```
sudo git clone https://github.com/LeGrandDevin/WAZUH-GRP3-WAZUH
```

Puis il faut configurer le remote system.

```
cd WAZUH-GRP3-WAZUH
sudo . scriptWazuhVM.sh
```

Ensuite il faut configurer Ansible et installer Wazuh sur le system Ansible.

```
cd WAZUH-GRP3-ANSIBLE
sudo . scriptAnsibleVM.sh
```

Puis il faut configurer les règles OSSEC sur le remote system.

```
cd WAZUH-GRP3-WAZUH
sudo . rulesetConfiguration.sh
```

Pour terminer il faut mettre en place un script permettant d'update les règles OSSEC toutes les semaines sur le remote system.

```
cd WAZUH-GRP3-WAZUH
sudo . wazuhAutoUpdate.sh
```

> Si vous rencontrez des erreurs dans une des étapes du script nous avons ajouté des commentaires dans le script expliquant chaque étape.

## Installation d'un agent Wazu
Cette installation demande 3 machines au minimum pour fonctionner, une machine Ansible un server wazuh et un remote system ou sera installé l'agent.
Le système d'éxploitation utilisé sur les VM est Debian.

> Le lancement de ces scripts vous demander les adresses IP de la machine de l'agent et du server wazuh.
> 
> Pour le bon fonctionnement veuillez passez en root avant d'exécuter les scripts avec la commande ``` su - ```.

Avant de vous lancer dans l'installation, veuillez télécharger Git sur la machine de l'agent.

```
apt install git
apt update
```

Pour commencer il faut cloner le dossier Agent sur le host agent depuis le GitHub du projet.

```
sudo git clone https://github.com/LeGrandDevin/WAZUH-GRP3-AGENT
```

Puis il faut configurer l'agent.

```
cd WAZUH-GRP3-AGENT
sudo . scriptAgentVM.sh
```

si vous n'avez pas cloné le repo ansible sur le host ansible faite la commmande suivante

```
sudo git clone https://github.com/LeGrandDevin/WAZUH-GRP3-ANSIBLE
```

ensuite sur le host ansible lancer le script d'instalation de l'agent
```
cd WAZUH-GRP3-AGENT
sudo . agentInstallScript.sh
```

> Si vous rencontrez des erreurs dans une des étapes du script nous avons ajouté des commentaires dans le script expliquant chaque étape.
