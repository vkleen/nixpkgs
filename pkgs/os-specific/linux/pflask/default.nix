{ lib, stdenv, fetchurl, python, wafHook }:

stdenv.mkDerivation rec {
  name = "pflask-${version}";
  version = "git-2018-09-14";
  rev = "9ac31ffe2ed29453218aac89ae992abbd6e7cc69";

  src = fetchurl {
    url = "https://github.com/ghedo/pflask/archive/${rev}.tar.gz";
    sha256 = "1hqn4sjpclkmnr8yl8pgarw61k96rg7vb8gcqpm2894206b3yjvm";
  };

  nativeBuildInputs = [ wafHook ];
  buildInputs = [ python ];

  meta = {
    description = "Lightweight process containers for Linux";
    homepage    = "https://ghedo.github.io/pflask/";
    license     = lib.licenses.bsd2;
    platforms   = lib.platforms.linux;
    maintainers = with lib.maintainers; [ ];
  };
}
