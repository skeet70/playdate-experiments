{
  description = "Playdate experimentation.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
    playdate-sdk.url = "github:headblockhead/nix-playdatesdk";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, playdate-sdk, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };
        rusttoolchain =
          pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
      in
      {
        # nix develop
        devShells.default = pkgs.mkShell {
          inputsFrom = [ playdate-sdk.defaultPackage.x86_64-linux ];
          buildInputs = with pkgs;
            [ rusttoolchain gcc-arm-embedded-11 openssl pkg-config ]
            ++ pkgs.lib.optionals pkgs.stdenv.isDarwin
              [ pkgs.darwin.apple_sdk.frameworks.Security ];
        };
      });
}
