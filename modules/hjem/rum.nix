{
  imports = [
    ./config.nix
    (import ../options.nix { omitBaseOptions = true; })
  ];
}
