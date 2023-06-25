#!/bin/sh
echo -ne '\033c\033]0;Jeu Avions Pioupiou\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Jeu Avions Pioupiou.x86_64" "$@"
