{ lib, stdenv, fetchFromGitHub, python3Packages }:

stdenv.mkDerivation {
  name = "bean-add-2020-11-27";

  src = fetchFromGitHub {
    owner = "simon-v";
    repo = "bean-add";
    rev = "6e6fe2fd7b9b53b5616ead629d4e2ad75cd1ea48";
    sha256 = "sha256-dYBBI2U8R6XCG87df8DQP0PPiAo2zOqBrC/6GSyAokw=";
  };

  propagatedBuildInputs = with python3Packages; [ python ];

  installPhase = ''
    mkdir -p $out/bin/
    cp bean-add $out/bin/bean-add
    chmod +x $out/bin/bean-add
  '';

  meta = {
    homepage = "https://github.com/simon-v/bean-add/";
    description = "beancount transaction entry assistant";

    # The (only) source file states:
    #   License: "Do what you feel is right, but don't be a jerk" public license.

    maintainers = with lib.maintainers; [ matthiasbeyer ];
  };
}

