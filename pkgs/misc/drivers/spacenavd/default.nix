{ stdenv, lib, fetchFromGitHub, fetchpatch, libX11, IOKit }:

stdenv.mkDerivation rec {
  version = "master";
  pname = "spacenavd";

  src = fetchFromGitHub {
    owner = "vkleen";
    repo = "spacenavd";
    rev = "23c17bfd70db2a1f14a48c4ad25c63a81b6645f5";
    sha256 = "sha256-Q2amZXPK+ygdqj9LKlhS+lMI6x4615CymNbjTBFO+gY=";
  };

  buildInputs = [ libX11 ]
    ++ lib.optional stdenv.isDarwin IOKit;

  configureFlags = [ "--disable-debug" ];

  makeFlags = [ "CC=${stdenv.cc.targetPrefix}cc" ];

  meta = with lib; {
    homepage = "http://spacenav.sourceforge.net/";
    description = "Device driver and SDK for 3Dconnexion 3D input devices";
    longDescription = "A free, compatible alternative, to the proprietary 3Dconnexion device driver and SDK, for their 3D input devices (called 'space navigator', 'space pilot', 'space traveller', etc)";
    license = licenses.gpl3Plus;
    platforms = platforms.unix;
    maintainers = with maintainers; [ sohalt ];
  };
}
