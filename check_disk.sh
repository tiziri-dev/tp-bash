#!/bin/bash

# Récupérer l'argument, ou 80 par défaut
SEUIL=${1:-80}

# Récupérer l'utilisation du disque (le / est la racine)
UTILISATION=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

echo "Utilisation actuelle du disque : ${UTILISATION}%"
echo "Seuil d'alerte : ${SEUIL}%"

# Vérifier si on dépasse le seuil
if [ "$UTILISATION" -ge "$SEUIL" ]; then
    echo "ALERTE : Espace disque dépassé !"
    exit 1
else
    echo "Tout va bien."
    exit 0
fi
