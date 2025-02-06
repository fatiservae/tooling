#!/bin/sh
# By Jefferson T. @ 2023
#
# Um tocador em mpv para linha de comando.

ajuda() {
  printf ' Ajuda:\n'
  printf ' --play          Reproduzir de xclip\n'
  printf ' --cmd           Reproduzir de cmd\n'
  printf ' --fuzzy         Adicionar com fzf\n'
  printf ' --clear         Limpar\n'
}

# Ideia: colocar o mpvlst-active como variavel de valor do PID para ser usado no --kill

[ -z "$1" ] && ajuda && exit
touch /tmp/mpvlst-active
workDir="$(pwd)";

case "$1" in 
  --play)
    if [ "$(< /tmp/mpvlst-active)" == "true" ]; then
      echo "{ \"command\": [\"loadfile\", \"$(xclip -o -selection clipboard)\", \"append\"] }" |  socat - /tmp/mpvsocket
    else
      echo "true" > /tmp/mpvlst-active;
      mpv --ytdl-format="bestvideo[height<=720]+bestaudio/best" --input-ipc-server=/tmp/mpvsocket "$(xclip -o -selection clipboard)" &&
      rm /tmp/mpv*
    fi
  ;; 
  --cmd)
    if [ "$(< /tmp/mpvlst-active)" == "true" ]; then
      echo "{ \"command\": [\"loadfile\", \""$2"\", \"append\"] }" |  socat - /tmp/mpvsocket;
    else
      echo "true" > /tmp/mpvlst-active;
      mpv --input-ipc-server=/tmp/mpvsocket "$2" && rm /tmp/mpvlst-active &
    fi
  ;;
  --clear)
    echo '{ "command": ["playlist-clear"] }' |  socat - /tmp/mpvsocket
  ;;
  --fuzzy)
    files="$(IFS=$'\n'; tree -fi --noreport "$2" | fzf -m)";

    if [ -z "$files" ]; then
      printf "Sem arquivos adicionados\n" && exit
    fi

    for file in "$files"; do
      if [ "$(< /tmp/mpvlst-active)" == "true" ]; then
        echo "{ \"command\": [\"loadfile\", \""$file"\", \"append\"] }" |  socat - /tmp/mpvsocket;
      else 
        echo "true" > /tmp/mpvlst-active;
        mpv --input-ipc-server=/tmp/mpvsocket "$file" &
          # Remove mpvlst-active apos reprodução encerrada
          rm /tmp/mpvlst-active;
      fi
    done
  ;;
  *)
    ajuda
  ;;
esac
