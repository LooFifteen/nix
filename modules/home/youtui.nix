{ pkgs, ... }:

let
  youtui = pkgs.rustPlatform.buildRustPackage rec {
    pname = "youtui";
    version = "0.0.22";

    src = pkgs.fetchFromGitHub {
      owner = "nick42d";
      repo = "youtui";
      rev = "youtui/v${version}";
      sha256 = "sha256-CEUrCaIDJh0JcCCyjxcd16rorhoyvyIveiCVVHvkhXg=";
    };

    useFetchCargoVendor = true;
    cargoHash = "sha256-TMXV6djSRI5y/P3FyhDETs+LnmukDOI+9t6R4X7DrCk=";

    nativeBuildInputs = with pkgs; [
      pkg-config
    ];

    buildInputs = with pkgs; [
      openssl
      alsa-lib
    ];

    # youtui integration tests require auth
    doCheck = false;
  };
in
{
  home.packages = [ youtui ];
}