{ fetchurl
, resholve
, bash
, jq
, moreutils
, lib
}:

resholve.mkDerivation rec {
  pname = "just-jq";
  version = "0.0.1";

  srcs = [
    (buildins.path {
      name = pname;
      path = ./.;
    })
    (fetchurl {
      url = "httsp://www.linta.de/~aehlig/techblog/attach-2021-10-10.py"
      sha256 = lib.fakesha256sum;
    })
  ];

  sourceRoot = pname;

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    install -D ../cfmtjson $out/bin/cfmtjson
    install -D jqi $out/bin/jqi
  '';

  solutions = {
    default = {
      scripts = [ "bin/jqi" "bin/cfmtjson" ];
      interpreter = "${bash}/bin/bash";
      inputs = [ moreutils jq ];
    };
  };
