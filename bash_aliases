#lists
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias l1='ls -1'

#dns 
alias digs='dig +short'
alias flushdns='sudo systemd-resolve --flush-caches'

#file explorer
alias nt='nautilus --no-desktop .'

#cleaning
alias cb='find . -name "*~" -exec rm {} \;'  # remove *~ backup files
alias dush='du -sh * | sort -h'              # space usage of current directory sorted to biggest
alias dfh='df -h'                            # df in human readable format

#finding
alias grep='grep --colour'
alias lkup='find -type f -print0 |xargs -0 grep --colour'

#copy paste from cli to buffer - requires apt install xsel
alias cbcp='xsel -ib'
alias cbpst='xsel -ob'
alias cbclr='xsel -cb'

#ubuntu gnome tricks with screens, keyboards and touchpads
alias tpoff='xinput --disable "SynPS/2 Synaptics TouchPad"'
alias tpon='xinput --enable "SynPS/2 Synaptics TouchPad"'
alias rotnor='xrandr --output eDP-1 --rotate normal'
alias kbitl='setxkbmap -layout us -variant intl'
alias kbnrm='setxkbmap -layout us'

#pdfbook from texlive-extra-utils in new version
alias pdfbook='pdfbook2'

# git stuff
# remove all local branches that are already merged 
alias gdbm='git branch --merged | grep -Ev "(^\*|^\+|master|main|dev)" | xargs --no-run-if-empty git branch -d'

#python stuff
alias pvmk='python -m venv .venv'

#ativate the python virtual-env 
pvac() {
  venv=${1:-".venv"};
  test -f ./${venv}/bin/activate &&  source ./${venv}/bin/activate;
  test -f ./${venv}/local/bin/activate &&  source ./${venv}/local/bin/activate;
  d=$(realpath "$(pwd)")
  echo "virtualenv activated at ${d}" 
}

#find the venv folder upwards, then pvac
pvup() {
  venv=${1:-".venv"}
  local d=$(realpath "$(pwd)")
  [[ -d "${d}/${venv}" ]] && pvac ${venv} && return;          # if we have venv found: activate and return
  [[ ${d} == "/" ]] && echo "${venv} not found"  && return;   # elseif we are up in the root, fail
  cd .. && pvup $venv                                         # else go up and continue
  cd ${d}                                                     # then go back
}

#mkdir then go into it
mgdir() {
  mkdir -p "${1}";
  if [[ "$?" == "0" ]]; then cd "${1}"; fi
}

#make noise
alarm() { 
  ( \speaker-test --frequency ${2:-660} --test sine )& pid=$!;
  sleep ${1:-1};
  kill -9 $pid; 
}

#home tv stuff
tv() {
   vlc -f udp://@${1}.vdtv.lan:50000 &
}

#make a qr code for a url
qr() {
  data=${1}
  size=${2:-200}
  [[ -z $data ]] && echo "no data to plot" && return;
  url=$(printf "https://quickchart.io/chart?cht=qr&chs=%dx%d&chl=%s" "$size" "$size" "$data")
  echo "$url"
  echo "to download use:"
  echo "curl --url \"$url\" -o qr.png"
}

#expand the uritemaplate https://shacl-play.sparna.fr/play/draw{?format,url}
shacl2uml() {
  echo "{\"format\": \"${2:-svg}\", \"url\": \"${1}\"}" | ute "https://shacl-play.sparna.fr/play/draw{?format,url}"
}


# docker stuff
docksh() {
  docker exec -it $(docker ps|grep ${1}|head -1|awk '{print $1}') /bin/bash
} 

# list groups of user in ${1}
grpls() {
    groups ${1} | sed -e 's/^.*: //' | tr ' ' '\n' | sort
}

# regular ping to check when servive comes up
ping-wait() {
  host=${1:-vdsrv01}
  waits=${2:-1}
  while true; do (ping -c 1 ${host} > /dev/null && echo -e "\nIT IS UP!") && break; echo -n "."; sleep ${waits}; done

}

