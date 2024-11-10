{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    love
    fish
  ];
  
    shellHook = ''
      echo "## Run 'love ./' to start the game"
      fish
      echo "exiting nix shell"
      exit 0
    '';
}