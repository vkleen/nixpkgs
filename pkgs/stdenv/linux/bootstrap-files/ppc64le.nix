{
  busybox = import <nix/fetchurl.nix> {
    url = http://www.kleen.org/power9/busybox;
    sha256 = "1zsfavwhf07kkrgk91727mrs7znfkllm0ywg8mbycnyj40hg9y88";
    executable = true;
  };
  bootstrapTools = import <nix/fetchurl.nix> {
    url = http://www.kleen.org/power9/bootstrap-tools.tar.xz;
    sha256 = "069jcxklywfbbxa5a0ygs3hkvn05cvfi29vv2jk0ppk6lgrrxrf9";
  };
}
