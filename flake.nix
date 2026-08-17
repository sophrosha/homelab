{
  description = "Server flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    arion = {
      url = "github:hercules-ci/arion";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, arion, zapret-discord-youtube, sops-nix, ... }@inputs:
    let
      system = "x86_64-linux";
      host = "p5kserv";
    in {
      nixosConfigurations.${host} = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
	      modules = [ 
	        ./default.nix 
	        arion.nixosModules.arion 
	        zapret-discord-youtube.nixosModules.withTestTools 
	        sops-nix.nixosModules.sops
	      ];
      };
    };
}
