{ myGitEmail, myGitUsername, ... }:

{
  programs.git = {
    enable = true;
    userName = myGitUsername;
    userEmail = myGitEmail;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.gh.enable = true;
}
