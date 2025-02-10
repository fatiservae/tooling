#!/bin/sh

ajuda() {
  printf ' Ajuda:\n'
  printf ' --play\t\t\tReproduzir de xclip\n'
  printf ' --play [resolution]\t\tEscolha resolução\n'
  printf ' --cmd\t\t\tReproduzir de cmd\n'
  printf ' --fuzzy\t\t\tAdicionar com fzf\n'
  printf ' --clear\t\t\tLimpar\n'
}

# Ideia: colocar o mpvlst-active como variavel de valor do PID para ser usado no --kill

[ -z "$1" ] && ajuda && exit
touch /tmp/mpvlst-active
#workDir="$(pwd)";

case "$1" in 
  --play)
    [ -z "$1" ] && ajuda && exit;
    if [ "$(< /tmp/mpvlst-active)" == "true" ]; then
      echo "{ \"command\": [\"loadfile\", \"$(xclip -o -selection clipboard)\", \"append\"] }" |  socat - /tmp/mpvsocket
    else
      echo "true" > /tmp/mpvlst-active;
      mpv --ytdl-format="bestvideo[height<="$2"]+bestaudio/best" --input-ipc-server=/tmp/mpvsocket "$(xclip -o -selection clipboard)" &&
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
