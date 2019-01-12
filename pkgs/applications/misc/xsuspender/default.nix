{ lib, stdenv, fetchFromGitHub, cmake, makeWrapper, pkgconfig
, glib, libwnck3, procps, gawk, coreutils, findutils, bash }:

with lib;

stdenv.mkDerivation rec {
  name = "xsuspender-${version}";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "kernc";
    repo = "xsuspender";
    rev = version;
    sha256 = "0d8gjaaq2vg7p1hb3qls0kqcg5y91dfdpacr20wpidwlvg9ci7lh";
  };

  outputs = [ "out" "man" "doc" ];

  nativeBuildInputs = [ cmake pkgconfig makeWrapper ];
  buildInputs = [ glib libwnck3 ];

  enableParallelBuilding = true;

  postInstall = ''
    wrapProgram $out/bin/xsuspender \
      --prefix PATH : "${makeBinPath [ procps gawk coreutils findutils bash ]}"
  '';

  meta = {
    description = "Auto-suspend inactive X11 applications.";
    homepage = "https://kernc.github.io/xsuspender/";
    license = licenses.wtfpl;
    maintainers = with maintainers; [ offline ];
    platforms = platforms.linux;
  };
}
