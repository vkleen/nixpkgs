{
  busybox = import <nix/fetchurl.nix> {
    url = http://www.kleen.org/power9/musl/busybox;
    sha256 = "0wcvfmplynfwhlirrmjswjh8wxdsxg4k46vajp64sz2bizb3111a";
    executable = true;
  };
  bootstrapTools = import <nix/fetchurl.nix> {
    url = http://www.kleen.org/power9/musl/bootstrap-tools.tar.xz;
    sha256 = "0rg8qgd138am2vm2rgjmb90ink1w3jd1116d88gc7dwfb7zwvzw2";
  };
}
