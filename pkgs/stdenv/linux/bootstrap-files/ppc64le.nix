{
  busybox = import <nix/fetchurl.nix> {
    url = http://ppc64le-bootstrap.s3-website.eu-central-1.amazonaws.com/glibc/busybox;
    hash = "sha256-X+JfohYZjzkWC/koxYhdegBHl4fmvUgs298r2oC/Rqw=";
    executable = true;
  };
  bootstrapTools = import <nix/fetchurl.nix> {
    url = http://ppc64le-bootstrap.s3-website.eu-central-1.amazonaws.com/glibc/bootstrap-tools.tar.xz;
    hash = "sha256-nbKlSAtmteDnkznW5bQ6oU7pb0rlyGdFU5Dd28xjWCA=";
  };
}
