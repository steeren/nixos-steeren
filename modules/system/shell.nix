{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.shell = {
    enable = lib.mkEnableOption "Enable bash shell with starship, fzf, oh-my-posh and nerd-fonts";

    formatter = lib.mkOption {
      type = lib.types.enum [
        "alejandra"
        "nixfmt"
        "nixfmt-rfc-style"
      ];
      default = "alejandra";
      description = "Which Nix formatter to install (alejandra, nixfmt, or nixfmt-rfc-style).";
    };

    aliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      description = "Custom Bash aliases.";
    };
  };

  config = lib.mkIf config.shell.enable {
    environment.systemPackages =
      (with pkgs; [
        bashInteractive
        starship
        fzf
        oh-my-posh
        nerd-fonts.fira-code
      ])
      ++ [
        (pkgs.${config.shell.formatter})
      ];

    programs.starship = {
      enable = true;
      settings = {
        add_newline = true;
      };
    };

    programs.bash = {
      promptInit = ''
        eval "$(${pkgs.starship}/bin/starship init bash)"
      '';
      interactiveShellInit = ''
        # Uncomment to switch to oh-my-posh instead of starship
        # eval "$(${pkgs.oh-my-posh}/bin/oh-my-posh init bash --config ${pkgs.oh-my-posh}/themes/jandedobbeleer.omp.json)"
      '';
    };
  };
}
