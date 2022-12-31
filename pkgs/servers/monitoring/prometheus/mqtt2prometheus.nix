{ pkgs
, lib
, buildGoModule
, fetchFromGitHub
, nixosTests
}:

buildGoModule rec {
  pname = "mqtt2prometheus";
  version = "master";

  src = fetchFromGitHub rec {
    owner = "hikhvar";
    repo = "mqtt2prometheus";
    rev = "74823e6ff1c63d35b9052dbbc6897856f4c69b14";
    hash = "sha256-Bf23iraydJUk9cFH1v2arfU9yEz1su2EavVnFX7f4Wg=";
  };

  vendorHash = "sha256-5P5J1HwlOFMaGj77k4jU8uJtm0XUIqdPT9abRcvHt2s=";

  buildPhase = ''
    make TARGET_FILE=mqtt2prometheus -j$NIX_BUILD_CORES
  '';

  installPhase = ''
    install -Dm755 ./mqtt2prometheus -t $out/bin
  '';

  passthru.tests = {
    inherit (nixosTests.prometheus-exporters) mqtt2prometheus;
  };

  meta = with lib; {
    description = "MQTT to Prometheus gateway ";
    homepage = "https://github.com/hikhvar/mqtt2prometheus";
    license = licenses.mit;
    # maintainers = with maintainers; [ nukaduka ];
  };
}
