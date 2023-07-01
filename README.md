Ce projet permet de configurer et d'utiliser Ansible comme outil d'automatisation pour déployer et configurer le système de détection d'intrusion Wazuh.

Les scripts d'installation vous demanderont vos identifiants, pensez à les préparer avant de lancer les scripts.

Pour commencer il faut configurer le remote system.
On commence par cloner le script puis on l'exécute.

```
sudo git clone --branch https://github.com/LeGrandDevin/WAZU-GRP3/scriptWazuhVM.sh
scriptWazuhVM.sh
```

Ensuite il faut configurer Ansible et installer Wazuh sur le remote system.

```
sudo git clone --branch https://github.com/LeGrandDevin/WAZU-GRP3/scriptAnsibleVM.sh
scriptAnsibleVM.sh
```

Pour terminer il faut mettre en place un script permettant d'update les règles OSSEC toutes les semaines.

```
sudo git clone --branch https://github.com/LeGrandDevin/WAZU-GRP3/wazuhAutoUpdate.sh
wazuhAutoUpdate.sh
```

Si vous rencontrez des erreurs dans une des étapes du script nous avons ajouté des commentaires dans le script expliquant chaque étape.
