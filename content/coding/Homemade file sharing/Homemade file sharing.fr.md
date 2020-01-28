---
author: "bernstein"
title: "Homemade file sharing"
slug: "homemade_filesharing_fr"
date: 2020-01-28
status: "original"
repo: "no repo"
description: "Une astuce utile avec ngrok pour partager des fichier temporairement."
---

# Homemade file sharing

Il arrive souvent que l'on veuille partager des fichiers sans avoir à se créer un compte sur un service d'hébergement, et aussi sans qu'il y ait persistance du fichier sur le service d'hébergement. Bref, qu'on veuille échanger des fichiers à une personne tierce rapidement à l'aide d'une URL, juste le temps qu'elle télécharge les fichiers.

Un moyen simple est de le faire à l'aide d'un tunnel ngrok, couplé à un simple serveur en Python. Explications.
## ngrok, kézako?
[ngrok](https://ngrok.com/product) est un logiciel léger permettant de créer un tunnel gratuitement entre votre machine et Internet, sans avoir à ouvrir les ports de votre box. 
Il permet notamment d'exposer un service momentanément pour la version gratuite. Très pratique pour faire des tests ou des démos d'applications, on peut aussi choisir sur quel port ngrok travaillera, et la version payante propose du chiffrement & une protection par mot de passe. Il fonctionne sur la plupart des systèmes d'exploitations (Windows, Linux, Mac OS).

### NB: 

Pour Mac OS & Windows, Python n'étant pas installé par défaut, il faut l'installer : [https://www.python.org/downloads/](https://www.python.org/downloads/).
On utilise Python mais on peut certainement utiliser d'autres langages vu l'usage qu'on en fait (Golang, Ruby ...). A vous de chercher!

Pensez à ajouter Python à votre PATH variable, afin de pouvoir l'utiliser peu importe le répertoire dans lequel vous vous trouvez ;).
## Partage temporaire de dossier en ligne

Tout d'abord, on télécharge ngrok sur [sur le site officiel](https://ngrok.com/download), et on décompresse l'archive.

Dans le dossier où se trouve le binaire de ngrok, on le lance:

Linux & Mac OS: `./ngrok http <port\`
Windows: `ngrok.exe http <port>`

Normalement, l'output ressemble à ça:
ngrok.png
Toujours dans le même répertoire, on lance:

`python -m SimpleHTTPServer <port>`

Désormais, n'importe quelle personne ayant l'URL peut avoir accès via HTTP aux fichiers présents dans le dossier :

directory.png

Il suffit de cliquer sur le fichier voulu pour le télécharger, on peut même aller dans les sous dossiers.

## Advantages

Un point positif par rapport aux sites d'hébergements, c'est le fait que les URLs fournies permettent de télécharger le fichier directement, permettant ainsi de télécharger simplement les fichiers à l'aide de wget, curl, ou tout autre service utilisant le protocole HTTP.

Aussi, ngrok offre une interface web afin de monitorer son activité, hébergée localement sur [http://localhost:4040/](http://localhost:4040/) lorsque le service tourne. Elle permet notamment de logger les requêtes faites sur son URL ... 

## Pour aller plus loin

Pour l'instant on a juste couplé ngrok à Python avec 1 seule commande. Mais comme dit plus haut, on pourrait faire des choses bien plus complexes, notamment en couplant ngrok à un serveur Python un peu plus élaboré, faisant différentes actions en fonction de la méthode de requête HTTP ... à vous de configurer ça :-)

Assez utile en somme pour faire une démo en ligne temporaire devant des clients ou des amis.

## Bonus

Un petit script bash automatisant toute la procédure ... ;)


    #!/usr/bin/env bash
    
    echo  "Downloading ngrok ..."
    wget -q https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
        
    echo  "Decompressing archive ..."
    unzip -q ngrok-stable-linux-amd64.zip    
    
    echo  "Launching ngrok ..."
    ./ngrok http 8000 | cat &
    
    echo  "Launching Python Server ..."
    python -m SimpleHTTPServer 8000 | cat &
   
    echo  "SUCCESS! Directory shared @:"
    echo  $(wget -qO- stdout http://127.0.0.1:4040/api/tunnels | jq -r '.tunnels[0].public_url')
     
    echo  "$(ps aux | grep ngrok | sed -n '1p')"
    
    echo  "$(ps aux | grep SimpleHTTPServer | sed -n '1p')"




 











