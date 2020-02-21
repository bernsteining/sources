---
author: "bernstein"
title: "Dumpin' a smartphone BGA eMMC"
slug: "smartphone_bga_dump"
date: 2020-01-20
status: "original"
description: "Voyons voir comment il est possible de dumper physiquement la mémoire d'un Smartphone Android ..."
---

# Dump d'une mémoire flash BGA (Samsung Galaxy S4)

Aujourd'hui, nous allons nous interesser au dump physique d'une mémoire interne de Samsung Galaxy S4. Quand je parle de dump physique, cela diffère d'un dump logique, où les données seraient récupérées à l'aide d'un dd. Ici, on va déssouder la puce pour enfin la lire. Explications.

**NB: Avant toute chose, il est important de préciser que ce genre de méthode est à utiliser en dernier recours, qu'un dump logique (si possible) est à favoriser. Le fait de déssouder la puce ne garantit pas forcément l'intégrité des données, et le risque de cramer la puce n'est pas négligeable.**

## Identification de la puce

A disposition, nous avons le circuit imprimé du téléphone, et les différents composants ainsi que leurs références sont donc visibles. 
A l'aide d'une loupe ou d'un microscope, on peut rapidement identifier la nature des différents composants en cherchant leurs références sur Internet (les google dorks peuvent s'avérer utiles). 
Une fois la mémoire interne identifiée, le but est de trouver sa datasheet, un .PDF contenant toutes les caractéristiques physiques la décrivant. On aura ainsi plus d'indice sur son format, comment la lire, etc...

### Différence BGA / SOIC : 
Petit point de vocabulaire, plusieurs types de puces existent, parmi eux BGA (Ball Grid Array) et SOIC (Small outline integrated circuit).

Les BGAs s'indentifient par le fait que la connexion de la puce au circuit imprimé se fait par des "billes" se situant en dessous de la puce. 

![BGA](https://www.multi-circuit-boards.eu/fileadmin/img/03_Design-Hilfe/bga/bga_leiterplatte_ball-grid-array.jpg)

Tandis qu'une SOIC s'identifient par le fait que la connexion de la puce au circuit imprimé se fait par ses "pattes" sur le côté.

![SOIC](http://fr.hobbytronics.co.uk/image/cache/data/soic-20-500x500.jpg)

Une différence majeure, qui rend les puces BGA bien plus difficiles à déssouder, de plus que les constructeurs ajoutent souvent de la colle.

## Déssoudage de la puce

Passons aux choses sérieuses, le retrait de la puce du circuit imprimé. Attention, chaud devant!

Pour la déssouder, on se sert d'un pistolet à air chaud. 

![Déssoudage de la puce à l'aide du pistolet à air chaud here](https://imgur.com/mSClZDt.jpg)

Afin d'éviter un choc thermique sur la puce, il est important de monter graduellement la température, et de la balayer continûment. Idem, il faut balayer continûment la puce pour ne pas la cramer. Certains disent qu'il peut être utile de la déssouder par le bas, afin d'éviter d'abîmer la puce.

Enfin, lorsqu'on est arrivé à la température maximale, à l'aide d'un stylo de retrait (et en forçant un peu, à cause de la colle), on vient retirer la puce.
### Le PCB et la puce déssoudée
![Le PCB et la puce dessoudée](https://imgur.com/7v7jM2J.png)

### Stylos pour retirer les puces
![Stylos](https://imgur.com/2eLmNfB.jpg)

Aussi, pour assurer au mieux la connectivité de la puce, il est conseillé de la nettoyer à l'aide de fluxclene:

![Nettoyage de la puce au fluxclene](https://imgur.com/WVFJrbK.jpg)
## Lecture de la puce

Pour lire les puces eMMC BGA, j'ai utilisé la box EMATE-X. 

![E-MATE X et ses sockets](https://imgur.com/dpri2GM.png)

Elle dispose d'un grand nombre de sockets pour lire de nombreux formats de puces eMMC BGA, ce qui la rend très pratique. 

De plus, elle est compatible avec un grand nombre de boxes d'exploitation de smartphone (Medusa Pro, Octoplus, Riffbox 1 & 2, Easy JTAG, UFI ...). 

Ayant à disposition la Riffbox 1, il m'a suffit de brancher le bon plug de l'EMATE-X (il y en a un pour chaque box d'exploitation), ainsi que le bon socket (correspondant au format de la puce eMMC BGA), afin de lire le contenu de la puce.

![enter image description here](https://imgur.com/RhBb7EP.jpg)

**NB: La plupart des Boxes d'exploitation citées plus haut fonctionnent à l'aide d'une licence/abonnement. Par chance, des credentials étaient hardcodés dans ma riffbox, me permettant ainsi d'utiliser le logiciel. Aussi, la plupart des solutions de ce genre fonctionnent sous Windows ... :(**

Une fois l'EMATE-X alimentée en micro-USB, et la Riffbox connecté à un PC sous Windows, la lecture de la puce a été rendue possible, et un dump de 8Go a fait son apparition *_*. Reste à l'investiguer, mais ça c'est un autre boulot!

A bientôt pour d'autres articles 8)


