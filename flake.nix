{
  description = "Dev environment template for Advent of Code!";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";

    # CHANGED: Using the latest *stable* NixOS channel.
    # This channel is more likely to have pre-built binaries (substitutes)
    # compared to the bleeding edge of 'nixpkgs-unstable'.
    # I'm using the latest stable release (e.g., 23.11) as an example.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    # If you prefer to stick closer to "latest", you can try:
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small"; 
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      perSystem = { pkgs, lib, ... }: {
        devShells.default =
          let
            # The latest stable GHC version available in this nixpkgs channel
            compiler-version = "ghc98";
            # Note: We still access the package set via the compiler-version
            hpkgs = pkgs.haskell.packages.${compiler-version};
            
            # Haskell packages to include
            packages = p: with p; [ split vector ];
            
            # Haskell and shell tooling
            tools = [
              (hpkgs.ghcWithPackages packages)
              hpkgs.ghcid
            ];
            # System libraries that need to be symlinked
            libraries = [ ];
            libraryPath = "${lib.makeLibraryPath libraries}";
          in pkgs.mkShell {
            name = "AOC";

            buildInputs = tools ++ libraries;

            LD_LIBRARY_PATH = libraryPath;
            LIBRARY_PATH = libraryPath;
          };

        # formatter = pkgs.alejandra;
      };
    };
}
