{
  busybox = import <nix/fetchurl.nix> {
    url = http://ppc64le-bootstrap.s3-website.eu-central-1.amazonaws.com/musl/busybox;
    hash = "sha256-gAmtTFf/LHw/WqLa8SSBYV2GJN6i4U6KTmHZPlXr0tQ=";
    executable = true;
  };
  bootstrapTools = import <nix/fetchurl.nix> {
    url = http://ppc64le-bootstrap.s3-website.eu-central-1.amazonaws.com/musl/bootstrap-tools.tar.xz;
    hash = "sha256-lm4IWRahNKBTz9JBcQmJJvnOWrDEzxC5rfQXFhdjGMc=";
  };
}
