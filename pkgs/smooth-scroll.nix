{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin {
  pname = "smooth-scroll";
  version = "0.1.4-unstable-2026-06-22";

  src = fetchFromGitHub {
    owner = "thomasschafer";
    repo = "smooth-scroll.hx";
    rev = "1ed8b088e465fb139389c36ad158ba4a2d9e1bbc";
    hash = "sha256-4lxGZrT4cEcg3jqae3uJGGGCSy4WeVZeJ0hIApMb7jY=";
  };

  meta = {
    description = "Smooth scrolling Helix plugin";
    homepage = "https://github.com/thomasschafer/smooth-scroll.hx";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
}
