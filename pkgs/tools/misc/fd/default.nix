{ lib, fetchFromGitHub, rustPlatform, installShellFiles }:

rustPlatform.buildRustPackage rec {
  pname = "fd";
  version = "8.2.1";

  src = fetchFromGitHub {
    owner = "vkleen";
    repo = "fd";
    rev = "6458b5813b57aadcd03bb768a1b1e9a23963a613";
    sha256 = "sha256-kqxuSCTWn3zB6Czoq0E+mnPygxbX8xKt4HGESmC1swg=";
  };

  cargoSha256 = "sha256-qGHBXRUxBXZpE9gPFaToVhhoTcHH14x3xlGhBUbD3Vg=";

  nativeBuildInputs = [ installShellFiles ];

  preFixup = ''
    installManPage doc/fd.1

    installShellCompletion $releaseDir/build/fd-find-*/out/fd.{bash,fish}
    installShellCompletion --zsh contrib/completion/_fd
  '';

  doCheck = false;

  meta = with lib; {
    description = "A simple, fast and user-friendly alternative to find";
    longDescription = ''
      `fd` is a simple, fast and user-friendly alternative to `find`.

      While it does not seek to mirror all of `find`'s powerful functionality,
      it provides sensible (opinionated) defaults for 80% of the use cases.
    '';
    homepage = "https://github.com/sharkdp/fd";
    license = with licenses; [ asl20 /* or */ mit ];
    maintainers = with maintainers; [ dywedir globin ma27 zowoq ];
  };
}
