{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    neovim
    gcc
    tree-sitter
  ];

  home.file."./.config/nvim/" = {
    source = ./config;
    recursive = true;
  };
}
