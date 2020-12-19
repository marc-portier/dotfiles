#lists
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias l1='ls -1'

#dns 
alias digs='dig +short'

#python stuff
alias pvac='source ./venv/bin/activate'
alias pvmk='virtualenv venv -p python3'

#file explorer
alias nt='nautilus --no-desktop .'

#cleaning
alias cb='find . -name "*~" -exec rm {} \;'

#finding
alias grep='grep --colour'
alias lkup='find -type f -print0 |xargs -0 grep --colour'

#ubuntu gnome tricks with screens, keyboards and touchpads
alias tpoff='xinput --disable "SynPS/2 Synaptics TouchPad"'
alias tpon='xinput --enable "SynPS/2 Synaptics TouchPad"'
alias rotnor='xrandr --output eDP-1 --rotate normal'
alias kbitl='setxkbmap -layout us -variant intl'
alias kbnrm='setxkbmap -layout us'

#home tv stuff
tv() {
   vlc -f udp://@${1}.vdtv.lan:50000 &
}
