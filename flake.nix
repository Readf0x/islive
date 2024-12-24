{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      perSystem = { system, pkgs, ... }: {
        devShells.default = pkgs.mkShell {
          GOPATH = "/home/readf0x/.config/go";
          packages = [ pkgs.go ];
        };
        packages = rec {
          islive = pkgs.buildGoModule {
            name = "islive";
            pname = "islive";

            src = ./.;

            vendorHash = null;

            meta = {
              description = "Check if a twitch streamer is live";
              mainProgram = "islive";
              homepage = "https://github.com/Readf0x/islive";
              license = pkgs.lib.licenses.cc0;
            };
          };
          default = islive;
        };
      };
    };
}
