{ lib, buildGoModule, fetchFromGitHub, nixosTests }:

buildGoModule rec {
  pname = "mikrotik-exporter-unstable";
  version = "2022-04-01";

  src = fetchFromGitHub {
    owner = "nshttpd";
    repo = "mikrotik-exporter";
    sha256 = "sha256-7CfeeNE7+PGpZpvmtRNs0sz07K+KBjK/gvIGk8qUIl0=";
    rev = "dc93f93f621ef5f184fab9b8a324e1143cf7dd51";
  };

  vendorSha256 = "sha256-ByH1ebFrKHd7YfEikPiycP8Xe547eGUEQgHdaBLBJ6s=";

  doCheck = false;

  passthru.tests = { inherit (nixosTests.prometheus-exporters) mikrotik; };

  meta = with lib; {
    inherit (src.meta) homepage;
    description = "Prometheus MikroTik device(s) exporter";
    license = licenses.bsd3;
    maintainers = with maintainers; [ mmilata ];
  };
}
