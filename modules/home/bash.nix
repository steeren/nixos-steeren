{ pkgs, ... }:

{
  programs.bash = {
    enable = true;

    shellAliases = {
      ls = "lsd --group-dirs=first";
      ll = "ls -lh";
      la = "ls -lha";
      ".." = "cd ..";
      "..." = "cd ../..";
      vi = "nvim";
      vim = "nvim";
      cat = "bat";

      update-system = "sudo nixos-rebuild switch --flake /etc/nixos/flake.nix#nixos";
      "updt-n-rb" = "sudo nix flake update && sudo nixos-rebuild switch --flake .";
      "rebuild" = "sudo nixos-rebuild switch --flake .";
      "update" = "sudo nix flake update";
    };
    initExtra = ''
      # Starship prompt
      eval "$(${pkgs.starship}/bin/starship init bash)"

      # Editor
      export EDITOR=nvim
      export VISUAL=code

      # Bash completion
      if [ -f "${pkgs.bash-completion}/etc/bash_completion" ]; then
        source "${pkgs.bash-completion}/etc/bash_completion"
      fi

      # Git autocompletion
      if [ -f "${pkgs.git}/share/git/completion/git-completion.bash" ]; then
        source "${pkgs.git}/share/git/completion/git-completion.bash"
      fi

      # FZF key bindings
      if [ -f "${pkgs.fzf}/share/fzf/key-bindings.bash" ]; then
        source "${pkgs.fzf}/share/fzf/key-bindings.bash"
      fi

      # Git branch picker with live preview
      fzf_git_branch() {
        git branch --all --color=always | \
        fzf --ansi --no-sort \
            --preview "git log --oneline --color=always -n 10 {1}" \
            --preview-window=up:10:wrap
      }
      alias gb='git checkout $(fzf_git_branch)'

      # Git commit picker with live preview
      fzf_git_commits() {
        git log --oneline --color=always | \
        fzf --ansi --no-sort \
            --preview "git show --color=always {1}" \
            --preview-window=up:10:wrap
      }
      alias gc='git show $(fzf_git_commits)'
    '';
  };
}
