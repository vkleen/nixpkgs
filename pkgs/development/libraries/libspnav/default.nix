{ stdenv, fetchurl, libX11 }:

stdenv.mkDerivation rec {
  version = "0.2.3";
  name = "libspnav-${version}";

  src = fetchurl {
    url = "http://downloads.sourceforge.net/spacenav/${name}.tar.gz";
    sha256 = "14qzbzpfdb0dfscj4n0g8h8n71fcmh0ix2c7nhldlpbagyxxgr3s";
  };

  buildInputs = [ libX11 ];

  configureFlags = [
    "--disable-debug"
  ];

  meta = with stdenv.lib; {
    description = "Alternative to the proprietary 3Dconnexion device driver and SDK for their 3D input devices";
    homepage = http://spacenav.sourceforge.net/;
    license = licenses.GPL;
    platforms = platforms.all;
  };
}
