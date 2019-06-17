sl() {
    eval $(ssh-agent)
    ssh-add "$1"
}

n() {
    nnn "$@"

    NNN_TMPFILE=/tmp/nnn

    if [ -f $NNN_TMPFILE ]; then
        . $NNN_TMPFILE
        rm -f $NNN_TMPFILE > /dev/null
    fi
}

opnvpn() {
    sudo openvpn --auth-nocache --config "$1"
}

mkp() {
    CORES=$(( $(lscpu | awk '/^Socket/{ print $2 }') * $(lscpu | awk '/^Core/{ print $4 }') ))
    echo "make -j ${CORES}"
    make -j ${CORES}
}

cmakebdirp() {
    CORES=$(( $(lscpu | awk '/^Socket/{ print $2 }') * $(lscpu | awk '/^Core/{ print $4 }') ))
    cmake --build $1 -- -j ${CORES}
}

#
# Ripped from Manjaro KDE's default .bashrc
#
# # ex - archive extractor
# # usage: ex <file>
ex () {
    if [ -f $1 ] ; then
     case $1 in
        *.tar.bz2)   tar xjf $1   ;;
        *.tar.gz)    tar xzf $1   ;;
        *.bz2)       bunzip2 $1   ;;
        *.rar)       unrar x $1     ;;
        *.gz)        gunzip $1    ;;
        *.tar)       tar xf $1    ;;
        *.tbz2)      tar xjf $1   ;;
        *.tgz)       tar xzf $1   ;;
        *.zip)       unzip $1     ;;
        *.Z)         uncompress $1;;
        *.7z)        7z x $1      ;;
        *)           echo "'$1' cannot be extracted via ex()" ;;
      esac
    else
        echo "'$1' is not a valid file"
  fi
}
