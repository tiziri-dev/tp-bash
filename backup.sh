#!/bin/bash
set -Eeuo pipefail

DOSSIER_A_SAUVEGARDER="./data"
DOSSIER_SAUVEGARDE="./backups"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
ARCHIVE="${DOSSIER_SAUVEGARDE}/backup_${DATE}.tar.gz"

# Vérifier que le dossier source existe
if [ ! -d "$DOSSIER_A_SAUVEGARDER" ]; then
    echo "Erreur : Le dossier $DOSSIER_A_SAUVEGARDER n'existe pas." >&2
    exit 1
fi

mkdir -p "$DOSSIER_SAUVEGARDE"

echo "Création de l'archive : $ARCHIVE"
tar -czf "$ARCHIVE" "$DOSSIER_A_SAUVEGARDER"

# Boucler sur les anciennes archives pour les supprimer
for fichier in $(find "$DOSSIER_SAUVEGARDE" -name "backup_*.tar.gz" -mtime +7); do
    echo "Suppression de l'ancienne archive : $fichier"
    rm -f "$fichier"
done

echo "Sauvegarde terminée avec succès."
exit 0
