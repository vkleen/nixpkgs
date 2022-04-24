{ lib, buildGoModule, fetchFromGitHub, makeWrapper }:
let
  version = "v0.17.2";
in buildGoModule rec {
  pname = "gqlgen";
  inherit version;
  patches = [ ./nixos_gql_template_root.patch ];
  src = fetchFromGitHub {
    owner = "99designs";
    repo = "gqlgen";
    rev = version;
    sha256 = "sha256-R+VIq3ZObQZCL4oecbKsxBwbltI4uZwFsc/88Ii74yo=";
  };
  vendorSha256 = "sha256-hFgYaukjOx8gc9Q6pN+jrP3iOA5MXowUvLiGa4jyH3c=";
  doCheck = false;
  allowGoReference = true;
  nativeBuildInputs = [ makeWrapper ];
  postInstall = ''
    wrapProgram $out/bin/gqlgen --set NIX_GQL_TEMPLATE_ROOT ${src}
  '';
}
