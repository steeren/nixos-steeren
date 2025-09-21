{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.neovim = {
    enable = lib.mkEnableOption "Enable Neovim via NVF";
  };

  config = lib.mkIf config.neovim.enable {
    programs.nvf = {
      enable = true;
      enableManpages = true;

      settings = {
        vim = {
          theme = {
            enable = true;
            name = "catppuccin";
            style = "mocha";
          };

          viAlias = true;
          vimAlias = true;

          options = {
            expandtab = true;
            shiftwidth = 2;
            tabstop = 2;
            termguicolors = true;
            number = true;
            relativenumber = true;
          };

          languages = {
            typescript = {
              enable = true;
              lsp.enable = true;
              format.enable = true;
            };
            javascript = {
              enable = true;
              lsp.enable = true;
              format.enable = true;
            };
            lua = {
              enable = true;
              lsp.enable = true;
            };
            nix = {
              enable = true;
              lsp.enable = true;
            };
            bash = {
              enable = true;
              lsp.enable = true;
            };
          };

          keymaps = [
            {
              key = "<leader>ff";
              mode = [ "n" ];
              action = "<cmd>Telescope find_files<cr>";
            }
            {
              key = "<leader>fg";
              mode = [ "n" ];
              action = "<cmd>Telescope live_grep<cr>";
            }
            {
              key = "gd";
              mode = [ "n" ];
              action = "<cmd>lua vim.lsp.buf.definition()<cr>";
            }
            {
              key = "gr";
              mode = [ "n" ];
              action = "<cmd>lua vim.lsp.buf.references()<cr>";
            }
            {
              key = "K";
              mode = [ "n" ];
              action = "<cmd>lua vim.lsp.buf.hover()<cr>";
            }
            {
              key = "<leader>rn";
              mode = [ "n" ];
              action = "<cmd>lua vim.lsp.buf.rename()<cr>";
            }
            {
              key = "<leader>f";
              mode = [ "n" ];
              action = "<cmd>lua vim.lsp.buf.format()<cr>";
            }
          ];

          # These are common plugin integrations NVF exposes inside vim.*
          telescope.enable = true;
          treesitter.enable = true;
          cmp.enable = true;
          gitsigns.enable = true;
          which-key.enable = true;
          autopairs.enable = true;
        };
      };
    };
  };
}
