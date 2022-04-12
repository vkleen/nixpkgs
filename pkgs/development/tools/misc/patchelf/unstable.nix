{ lib, stdenv, fetchurl, autoreconfHook, fetchFromSourcehut, unstableGitUpdater }:

stdenv.mkDerivation rec {
  pname = "patchelf";
  version = "unstable-vkleen";

  src = fetchFromSourcehut {
    owner = "~vkleen";
    repo = "patchelf";
    domain = "sr.ht.kleen.org";
    rev = "72f5529c3bc109204e0f250b1666afb9c8436f9f";
    sha256 = "sha256-lhvkU32OnmeKQ74hsCHlPd5SnJAgv9j6hWujS8Q3plU=";
  };

  setupHook = [ ./setup-hook.sh ];

  nativeBuildInputs = [ autoreconfHook ];
  buildInputs = [ ];

  doCheck = !stdenv.isDarwin;

  passthru = {
    updateScript = unstableGitUpdater {
      url = "https://git.sr.ht.kleen.org/~vkleen/patchelf";
    };
  };

  meta = with lib; {
    homepage = "https://github.com/NixOS/patchelf";
    license = licenses.gpl3;
    description = "A small utility to modify the dynamic linker and RPATH of ELF executables";
    maintainers = [ maintainers.eelco ];
    platforms = platforms.all;
  };
}
