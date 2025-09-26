echo "Updateing flake"
# sudo nix flake update

echo "Rebuilding NixOS configuration..."
sudo nixos-rebuild switch --flake .