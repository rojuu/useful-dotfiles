sl() {
	eval $(ssh-agent)
	ssh-add "$1"
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