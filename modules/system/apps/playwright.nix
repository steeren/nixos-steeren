# sub/playwright-home.nix
{
  config,
  pkgs,
  specialArgs,
  ...
}:

{
  home-manager.users.${specialArgs.username} =
    { config, pkgs, ... }:
    {

      # Environment variables for Playwright
      home.sessionVariables = {
        NODE_ENV = "development";
        PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright}/share/playwright/browsers";
        PLAYWRIGHT_CHROMIUM_ARGS = "--no-sandbox";
        PLAYWRIGHT_FIREFOX_ARGS = "--no-sandbox";
        PLAYWRIGHT_WEBKIT_ARGS = "--no-sandbox";
      };
    };
}
