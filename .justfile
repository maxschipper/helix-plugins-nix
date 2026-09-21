# https://just.systems

default: update check

update:
    ./update.sh

check:
    NIXPKGS_ALLOW_UNFREE=1 nix flake check --impure --keep-going
