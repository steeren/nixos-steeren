# Worklog Notes

_what worked, what didn't, what nearly broke me_

## Neovim/LazyVim

This was an epic pain in the ass. I relied heavily on ChatGPT and it was very frustrating. I gave up trying to install Neovim + configuring it correctly. That was just an epic waste of time. You need to really know what you're doing and I don't.
In the end I fell back to lazyvim. In order to install and partially configure Lazyvim, a flake sub-module was used to install the main binaries (used by plugins) and a init.lua file was copied over to finish the job. This is not how we want it. This needs proper review.
Issue is, we want the NixOS flake to take us from a clean install, right up to a fully setup machine - the closest we can getting as system working as if it had been set up months ago. The less manual steps, shit to remember, the better. But there is a fine line between pushing eveything into a NixOS flake and perhaps stowing stuff, where we have the freedom without any red-tape to alter configs and just re-stow them. Having the slower round trip of having to wiggle any and all changes into a Flake sub-module or lua script designed to bring a system from zero to working, might be more effort than we want.

## Flatpak

It doesn't work - setting the main repo seems to be the issue. We need flatpak and want to be able to use it to install shit we otherwise can't get good support for, directly through NixOS. Minecraft is an example.
