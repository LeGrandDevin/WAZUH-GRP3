Le système utilisé sur les VM est Debian.

Ce projet permet de configurer et d'utiliser Ansible comme outil d'automatisation pour déployer et configurer le système de détection d'intrusion Wazuh.

Les scripts d'installation vous demanderont vos identifiants, pensez à les préparer avant de lancer les scripts.

Pour le bon fonctionnement des script veuillez vous assurer que votre système utilise la commande sudo sinon passez en root avant d'exécuter les scripts.

Pour commencer il faut cloner le projet depuis GitHub.
```
sudo git clone https://github.com/LeGrandDevin/WAZUH-GRP3
```

Puis il faut configurer le remote system.

```
sudo . ./wazuh/scriptWazuhVM.sh
```

Ensuite il faut configurer Ansible et installer Wazuh sur le remote system.

```
sudo . ./ansible/scriptAnsibleVM.sh
```

Puis il faut configurer les règles OSSEC sur le remote system

```
sudo . ./wazuh/scriptOSSECruleset.sh
```

Pour terminer il faut mettre en place un script permettant d'update les règles OSSEC toutes les semaines.

```
sudo . ./wazuh/wazuhAutoUpdate.sh
```

Si vous rencontrez des erreurs dans une des étapes du script nous avons ajouté des commentaires dans le script expliquant chaque étape.
