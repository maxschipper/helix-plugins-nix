{
  buildHelixPluginWithNative,
  fetchFromGitHub,
  lib,
}:
buildHelixPluginWithNative {
  pname = "helix-file-watcher";
  version = "0.1.4-unstable-2026-06-22";

  src = fetchFromGitHub {
    owner = "mattwparas";
    repo = "helix-file-watcher";
    rev = "e118b7552ec7697c560a24b48880c92d6aa4476e";
    hash = "sha256-AvUihtnJtVZ6cLJJrNzhTmt/ZT1lZzprCRbuAfbzRc0=";
  };

  cargoHash = "sha256-RhxKQSydcY48/aWZGPbJe6pFrKptynMV35BQSD16tXo=";

  meta = {
    description = "Helix file watcher plugin";
    homepage = "https://github.com/mattwparas/helix-file-watcher";
    license = lib.licenses.unfree;
    # maintainers = with lib.maintainers; [ ];
  };
}
