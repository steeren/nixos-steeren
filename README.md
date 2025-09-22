# Personal NIX OS Configuration

This is my very much "WIP" NixOS configuration. It expects a .secrets.nix file at the root (which for obvious reasons should not be checked in).

The structure is based on this:

```perl

modules/
├── system.nix          # imports common system modules
├── home.nix            # imports common home modules
├── system/
│   ├── hardware.nix    # generic hardware config
│   ├── packages.nix
│   ├── settings.nix
│   ├── users.nix
│   └── ...
├── home/
│   ├── bash.nix
│   ├── git.nix
│   └── ...
└── profiles/
    ├── laptop.nix      # laptop-specific config (monitors, power mgmt)
    ├── desktop.nix     # desktop-specific config (e.g. GPU, no battery stuff)
    ├── workstation.nix # optional role with extra dev tools
    └── gaming.nix      # optional role for gaming setup

```

Where there is a clear distinction between "system" (standard flakes) and "home" which is everything "home-manager" related.

This is by NO MEANS a fully functional, tried and tested setup.
