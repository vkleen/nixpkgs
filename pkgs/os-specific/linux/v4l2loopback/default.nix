{ lib, stdenv, fetchFromGitHub, kernel, kmod }:

stdenv.mkDerivation rec {
  name = "v4l2loopback-${version}-${kernel.version}";
  version = "81b8df79107d1fbf392fdcbaa051bd227a9c94c1";

  src = fetchFromGitHub {
    owner = "umlaeute";
    repo = "v4l2loopback";
    rev = version;
    hash = "sha256-2Kj3IdbKbeTdSyUdSXTDNeWKF1IvmchciXZpX8e0KtA=";
  };

  hardeningDisable = [ "format" "pic" ];

  preBuild = ''
    substituteInPlace Makefile --replace "modules_install" "INSTALL_MOD_PATH=$out modules_install"
    sed -i '/depmod/d' Makefile
    export PATH=${kmod}/sbin:$PATH
  '';

  nativeBuildInputs = kernel.moduleBuildDependencies;

  buildInputs = [ kmod ];

  makeFlags = [
    "KERNELRELEASE=${kernel.modDirVersion}"
    "KERNEL_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  postInstall = ''
    mkdir -p $out/bin
    install -m0755 utils/v4l2loopback-ctl $out/bin
  '';

  meta = with lib; {
    description = "A kernel module to create V4L2 loopback devices";
    homepage = "https://github.com/umlaeute/v4l2loopback";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ fortuneteller2k ];
    platforms = platforms.linux;
  };
}
