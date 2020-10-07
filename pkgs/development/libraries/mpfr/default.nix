{ lib, stdenv, fetchurl, gmp }:

# Note: this package is used for bootstrapping fetchurl, and thus
# cannot use fetchpatch! All mutable patches (generated by GitHub or
# cgit) that are needed here should be included directly in Nixpkgs as
# files.

stdenv.mkDerivation rec {
  version = "4.1.0";
  pname = "mpfr";

  src = fetchurl {
    urls = [
      #"https://www.mpfr.org/${name}/${name}.tar.xz"
      "mirror://gnu/mpfr/${pname}-${version}.tar.xz"
    ];
    sha256 = "0zwaanakrqjf84lfr5hfsdr7hncwv9wj0mchlr7cmxigfgqs760c";
  };

  outputs = [ "out" "dev" "doc" "info" ];

  # mpfr.h requires gmp.h
  propagatedBuildInputs = [ gmp ];

  configureFlags =
    lib.optional stdenv.hostPlatform.isSunOS "--disable-thread-safe" ++
    lib.optional stdenv.hostPlatform.is64bit "--with-pic" ++
    lib.optional stdenv.isPower9 "--disable-decimal-float";

  doCheck = true; # not cross;

  enableParallelBuilding = true;

  meta = {
    homepage = "https://www.mpfr.org/";
    description = "Library for multiple-precision floating-point arithmetic";

    longDescription = ''
      The GNU MPFR library is a C library for multiple-precision
      floating-point computations with correct rounding.  MPFR is
      based on the GMP multiple-precision library.

      The main goal of MPFR is to provide a library for
      multiple-precision floating-point computation which is both
      efficient and has a well-defined semantics.  It copies the good
      ideas from the ANSI/IEEE-754 standard for double-precision
      floating-point arithmetic (53-bit mantissa).
    '';

    license = lib.licenses.lgpl2Plus;

    maintainers = [ ];
    platforms = lib.platforms.all;
  };
}
