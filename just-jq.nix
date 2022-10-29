{ fetchurl
, resholve
, bash
, jq
, moreutils
, python3
, lib
}:

resholve.mkDerivation rec {
  pname = "just-jq";
  version = "0.0.1";

  src = ./.;

  cfmtjson = fetchurl {
      url = "https://www.linta.de/~aehlig/techblog/attach-2021-10-10-bsd.py";
      sha256 = "sha256-ytSGQxVJhVrU5dnaA2Fcex3BylYVdLY1U0YKF8pv65Y=";
    };

  buildInputs = [ python3 ];


  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    install -D $cfmtjson $out/bin/cfmtjson
    chmod +x $out/bin/cfmtjson
    install -D jqi $out/bin/jqi
  '';

  solutions = {
    default = {
      scripts = [ "bin/jqi" ];
      interpreter = "${bash}/bin/bash";
      inputs = [ moreutils jq "bin" ];
    };
  };

  meta = with lib; {
    license = licenses.bsd2;
  };
}
