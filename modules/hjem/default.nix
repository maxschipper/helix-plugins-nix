{
  imports = [
    ./config.nix
    (import ../options.nix { })
  ];
}
