#!/bin/bash

# Πίνακας για όλα τα πακέτα που θα πάνε στο apt install
all_packages=("$@")
# Πίνακας για να κρατήσουμε όσα ορίσματα ξεκινάνε από python
python_apps=()

for arg in "$@"; do
    if [[ $arg == python* ]]; then
        python_apps+=("$arg")
    fi
done

# 1. Εγκατάσταση όλων των πακέτων που έδωσες (python, php, κλπ)
echo "Εγκατάσταση μέσω apt: ${all_packages[*]}"
sudo apt update && sudo apt install -y "${all_packages[@]}"

# 2. Εκτέλεση των pip εντολών για κάθε όρισμα που ξεκίναγε από python
for py in "${python_apps[@]}"; do
    echo "--- Ρύθμιση Pip για το: $py ---"
    sudo "$py" -m ensurepip --altinstall
    sudo "$py" -m pip install --upgrade pip
done
