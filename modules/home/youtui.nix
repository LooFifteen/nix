{ pkgs, ... }:

let
  youtui = pkgs.rustPlatform.buildRustPackage rec {
    pname = "youtui";
    version = "0.0.25";

    src = pkgs.fetchFromGitHub {
      owner = "nick42d";
      repo = "youtui";
      rev = "youtui/v${version}";
      sha256 = "sha256-hxoRrt0A2JoZdjxoh69b7F3i0+m0GOlggcpihlj4LOY=";
    };

    useFetchCargoVendor = true;
    cargoHash = "sha256-sXu6Db1kgNQN5QUdwjKEpypML6DFG/oU/mazxdZFM7Y=";

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
