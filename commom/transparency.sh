#!/usr/bin/bash
# Alterna entre opaco e transparente em alacritty

[[ ! -f ~/.alacritty.toml ]] && notify-send "alacritty.yml does not exist" && exit 0
opacity=$(awk '$1 == "opacity" {print $3; exit}' ~/.alacritty.toml)
case $opacity in
  1)
    toggle_opacity=0.7
    ;;
  *)
    toggle_opacity=1
    ;;
esac
sed -i -- "s/opacity = $opacity/opacity = $toggle_opacity/" ~/.alacritty.toml
