alias vybld_current='docker pull vyos/vyos-build:current && docker run --rm -it \
    -v "$HOME/vyos-build-current":/vyos \
    -v "$HOME/.gitconfig":/etc/gitconfig \
    -v "$HOME/.bash_aliases":/home/vyos_bld/.bash_aliases \
    -v "$HOME/.bashrc":/home/vyos_bld/.bashrc \
    -w /vyos --privileged --sysctl net.ipv6.conf.lo.disable_ipv6=0 \
    -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
    vyos/vyos-build:current bash'

alias vybld_equuleus='docker pull vyos/vyos-build:equuleus && docker run --rm -it \
    -v "$HOME/vyos-build-equuleus":/vyos \
    -v "$HOME/.gitconfig":/etc/gitconfig \
    -v "$HOME/.bash_aliases":/home/vyos_bld/.bash_aliases \
    -v "$HOME/.bashrc":/home/vyos_bld/.bashrc \
    -w /vyos --privileged --sysctl net.ipv6.conf.lo.disable_ipv6=0 \
    -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
    vyos/vyos-build:equuleus bash'

alias vybld_sagitta='docker pull vyos/vyos-build:sagitta && docker run --rm -it \
    -v "$HOME/vyos-build-sagitta":/vyos \
    -v "$HOME/.gitconfig":/etc/gitconfig \
    -v "$HOME/.bash_aliases":/home/vyos_bld/.bash_aliases \
    -v "$HOME/.bashrc":/home/vyos_bld/.bashrc \
    -w /vyos --privileged --sysctl net.ipv6.conf.lo.disable_ipv6=0 \
    -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
    vyos/vyos-build:sagitta bash'
