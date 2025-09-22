{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bashInteractive
    starship
    fzf
    git
    bash-completion
    noto-fonts
    noto-fonts-emoji
    fira-code
    nerd-fonts.fira-code
    bat
    delta
    prettierd
  ];
}
