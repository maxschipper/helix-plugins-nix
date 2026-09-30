# https://just.systems

default: update check

update:
    ./update.sh

check:
    nix flake check --keep-going
