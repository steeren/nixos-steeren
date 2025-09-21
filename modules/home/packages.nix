{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bashInteractive
    starship
    fzf
    oh-my-posh
    git
    bash-completion
    noto-fonts
    noto-fonts-emoji
    fira-code
    nerd-fonts.fira-code
    bun
    bat
    delta
  ];
}
