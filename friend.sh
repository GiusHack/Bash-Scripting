#!/bin/bash

# Fonction pour raconter une blague sélectionnée au hasard
tell_joke() {
  jokes=("Pourquoi les Geek sont-ils fiers ? Parce qu'ils ont une Gygabyte. (Giga bite)!"
          "A quoi sert Internet Explorer ? A télécharger Google Chrome !"
          "Quand est-ce que Windows ne bug pas ? Quand l'ordinateur est éteint. ")

  # Sélectionner une blague au hasard
  random_index=$((RANDOM % ${#jokes[@]}))
  joke="${jokes[$random_index]}"

  echo "Robot: $joke"
}

# Fonction pour afficher l'heure (la date)
show_time() {
  current_time=$(date +"%T")
  echo "Robot: Il est $current_time."
}

# Fonction pour calculer une équation simple
calculate_equation() {
  equation=$1
  result=$(echo "scale=2; $equation" | bc)
  echo "Robot: Le résultat de l'équation $equation est $result"
}

# Partie interactive
interactive_mode() {
  echo "Robot: Bonjour ! Je suis un robot intelligent. Posez-moi une question, donnez-moi une commande ou entrez une équation."

  while true; do
    read -p "Vous: " user_input

    case $user_input in
      "quelle heure est-il?")
        show_time
        ;;
      "raconte-moi une blague")
        tell_joke
        ;;
      "exit")
        echo "Robot: Au revoir !"
        break
        ;;
      *)
        # Vérifier si l'entrée est une équation
        if [[ $user_input =~ ^[0-9.+-/*\ ]+$ ]]; then
          calculate_equation "$user_input"
        else
          echo "Robot: Désolé, je ne comprends pas. Pouvez-vous reformuler votre question, votre commande ou entrer une équation ?"
        fi
        ;;
    esac
  done
}

# Partie non interactive
non_interactive_mode() {
  case $1 in
    "heure")
      show_time
      ;;
    "blague")
      tell_joke
      ;;
    *)
      # Vérifier si l'argument est une équation
      if echo "$1" | bc >/dev/null 2>&1; then
      
        calculate_equation "$1"
      else
        echo "Robot: Désolé, je ne comprends pas. Veuillez spécifier 'heure', 'blague' ou une équation valide."
      fi
      ;;
  esac
}

# Vérifier si des arguments sont fournis en ligne de commande
if [ $# -gt 0 ]; then
  non_interactive_mode "$1"
else
  interactive_mode
fi
