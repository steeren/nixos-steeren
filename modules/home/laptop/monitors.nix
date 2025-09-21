{ config, ... }:

{
  home.file.".config/monitors.xml".source = ./monitors.xml;
}
