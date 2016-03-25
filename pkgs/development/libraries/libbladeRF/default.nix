{ stdenv, fetchFromGitHub, pkgconfig, cmake, git, doxygen, help2man, tecla
, libusb1, udev }:

stdenv.mkDerivation rec {
  version = "1.5.1";
  name = "libbladeRF-v${version}";

  src = fetchFromGitHub {
    owner = "Nuand";
    repo = "bladeRF";
    rev = "libbladeRF_v${version}";
    sha256 = "04b6n4lyp6xch6yyvjmfhnaczgfgvrwi8vqfn30akpfgc8kqq895";
  };

  buildInputs = [ pkgconfig cmake git doxygen help2man tecla libusb1 udev ];

  # Fixup shebang
  prePatch = "patchShebangs host/utilities/bladeRF-cli/src/cmd/doc/generate.bash";

  # Let us avoid nettools as a dependency.
  patchPhase = ''
    sed -i 's/$(hostname)/hostname/' host/utilities/bladeRF-cli/src/cmd/doc/generate.bash
  '';

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Debug"
    "-DUDEV_RULES_PATH=etc/udev/rules.d"
    "-DBLADERF_GROUP=bladerf"
    "-DINSTALL_UDEV_RULES=ON"
    "-DBUILD_DOCUMENTATION=ON"
  ];

  meta = with stdenv.lib; {
    homepage = https://www.nuand.com/;
    description = "Supporting library of the BladeRF SDR opensource hardware";
    license = licenses.lgpl21;
    maintainers = with maintainers; [ funfunctor ];
    platforms = platforms.linux;
  };
}
