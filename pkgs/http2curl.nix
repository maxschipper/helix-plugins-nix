{
  buildHelixPlugin,
  fetchFromGitHub,
  lib,
}:
buildHelixPlugin (finalAttrs: {
  pname = "http2curl";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "waddie";
    repo = "http2curl.scm";
    tag = "v${finalAttrs.version}";
    hash = "sha256-wsiJLJAdxX08vEGUdJ+qe3pwhC0x2XbmzJbIC38ywVQ=";
  };

  meta = {
    description = "A Steel Scheme cog to translate a .http request to curl";
    homepage = "https://github.com/waddie/http2curl.scm";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
})
