# users.nix
#
# Configures system users, including the primary user account,
# password settings, and sudo privileges.
{
  config,
  pkgs,
  specialArgs,
  ...
}: # Added nixosUsername and passwordHash to arguments

{
  # Define the primary user account.
  users.users.${specialArgs.username} = {
    # Use the passed nixosUsername argument
    isNormalUser = true;
    extraGroups = [
      "flatpak"
      "disk"
      "qemu"
      "kvm"
      "libvirtd"
      "sshd"
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "libvirtd"
      "root"
    ];
    initialHashedPassword = specialArgs.passwordHash; # Use the passed passwordHash argument

    # shell = pkgs.zsh; # Set the default shell to Zsh
    shell = pkgs.bash; # Set the default shell to Bash
  };

  # Set the root user's password to be the same as the primary user's password.
  users.users.root = {
    hashedPassword = specialArgs.passwordHash; # Use the passed passwordHash argument
  };

  # Configure sudo access.
  security.sudo = {
    wheelNeedsPassword = false;
  };

}
