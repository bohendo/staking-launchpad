{
  description = "staking-launchpad";

  inputs = {
    nixpkgs24.url = "github:nixos/nixpkgs/856556b164d56f63434d2dd3e954f00f4b3a075f"; # v24.05 on 240912
    nixpkgs23.url = "github:nixos/nixpkgs/nixos-23.05";
    utils.url = "github:numtide/flake-utils/b1d9ab70662946ef0850d488da1c9019f3a9752a"; # main on 240311
  };

  outputs = inputs: with inputs;
    utils.lib.eachDefaultSystem (system:
      let
        pkgs24 = import nixpkgs24 {
          inherit system;
          config.allowUnfree = true;
        };

        pkgs23 = import nixpkgs23 {
          inherit system;
          config = {
            allowUnfree = true;
            permittedInsecurePackages = [ "nodejs-16.20.2" ];
          };
        };
      in
      rec {

        devShells = {
          default = pkgs24.mkShell {
            buildInputs = with pkgs24; [
              python3
              libgcc
              (pkgs24.yarn.override {
                nodejs = pkgs23.nodejs_16;
              })
              pkgs23.nodejs_16
            ];
          };
        };

      }
    );
}
