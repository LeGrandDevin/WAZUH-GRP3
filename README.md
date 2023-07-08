Cette installation demande 2 machines au minimum pour fonctionner, une machine Ansible et un remote system ou sera installé Wazuh.
Le système d'éxploitation utilisé sur les VM est Debian.

Ce projet permet de configurer et d'utiliser Ansible comme outil d'automatisation pour déployer et configurer le système de détection d'intrusion Wazuh.

Les scripts d'installation vous demanderont vos identifiants, pensez à les préparer avant de lancer les scripts.

Pour le bon fonctionnement des script veuillez vous assurer que votre système utilise la commande sudo sinon passez en root avant d'exécuter les scripts.

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

Si vous rencontrez des erreurs dans une des étapes du script nous avons ajouté des commentaires dans le script expliquant chaque étape.
