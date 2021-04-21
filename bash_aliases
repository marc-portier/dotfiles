#lists
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias l1='ls -1'

#dns 
alias digs='dig +short'

#file explorer
alias nt='nautilus --no-desktop .'

#cleaning
alias cb='find . -name "*~" -exec rm {} \;'

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

#python stuff
alias pvmk='virtualenv venv -p python3'

#ativate the python virtual-env 
pvac() {
  venv=${1:-"venv"};
  source ./${venv}/bin/activate;
  d=$(realpath "$(pwd)")
  echo "virtualenv activated at ${d}" 
}

#find the venv folder upwarts, then pvac
pvup() {
  venv=${1:-"venv"}
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
  url=$(printf "https://chart.googleapis.com/chart?cht=qr&chs=%dx%d&chl=%s" "$size" "$size" "$data")
  echo "$url"
  echo "to download use:"
  echo "curl --url \"$url\" -o qr.png"
}

#expand the uritemaplate https://shacl-play.sparna.fr/play/draw{?format,url}
shacl2uml() {
  #have to check further -- looks like there is bug in the rfc6570 implementation in python package uritemplates -- triling } ??
  #echo "{\"format\": \"${2:-svg}\", \"url\": \"${1}\"}" | ute "https://shacl-play.sparna.fr/play/draw{?format,url}"
  # even more odd -- this seems to work
  echo "{\"format\": \"${2:-svg}\", \"url\": \"${1}\"}" | ute "https://shacl-play.sparna.fr/play/draw{?format,url"
}
