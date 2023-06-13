#!/bin/bash

# Récupérer le code HTML de la page Web
curl "https://webscraper.io/test-sites/e-commerce/allinone/computers/laptops" -o fichier_temporaire


# Extraire les noms
nom=$(sed -n 's/.*<a href="\/test-sites\/e-commerce\/allinone\/product\/[^"]*" class="title" title="\(.*\)<\/a>/\1/p' fichier_temporaire
 | awk '!seen[$0]++')

# Extraire les descriptions et supprimer les occurrences de '&quot;'
descriptions=$(sed -n 's/.*<p class="description">\([^<]*\)<\/p>/\1/p' fichier_temporaire
 | sed 's/&quot;//g')

# Extraire les prix
prix=$(sed -n 's/.*<h4 class="pull-right price">\([^<]*\)<\/h4>/\1/p' fichier_temporaire
)

# Afficher les résultats avec une ligne vide entre chaque ordinateur portable
echo "nom | Description | Prix"
echo "------------------------"

# Utiliser la commande 'paste' pour fusionner les colonnes
paste -d " | " <(echo "$nom") <(echo "$descriptions") <(echo "$prix") |
while IFS=" | " read -r name description price; do
    echo "$name | $description | $price"
    echo
done

# Supprimer le fichier temporaire
rm fichier_temporaire

