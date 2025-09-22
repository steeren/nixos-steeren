{
  config,
  pkgs,
  lib,
  ...
}:

let
  nvimConfigDir = "${config.home.homeDirectory}/.config/nvim";
in
{
  home.packages = with pkgs; [
    nodejs
    yarn
    prettierd
    lua-language-server
    bash-language-server
    typescript-language-server
    nixpkgs-fmt
  ];

  programs.neovim = {
    enable = true;

  };

  # Link the init.lua reproducibly
  home.file.".config/nvim/init.lua".source = ./lua/lazyvim/init.lua;
}
