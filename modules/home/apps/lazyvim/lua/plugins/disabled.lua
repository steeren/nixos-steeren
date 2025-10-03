-- NOTE: disabled all LazyVim plugins
return {
  -- CODING
  -- blink.cmp
  { "saghen/blink.cmp",                            enabled = true},
  -- nvim-snippets
  { "garymjr/nvim-snippets",                       enabled = true },
  { "rafamadriz/friendly-snippets",                enabled = true },
  -- mini.pairs
  { "echasnovski/mini.pairs",                      enabled = true },
  -- ts-comments.nvim
  { "folke/ts-comments.nvim",                      enabled = true },
  -- mini.ai
  { "mini.ai",                                     enabled = true },
  -- lazydev.nvim
  { "folke/lazydev.nvim",                          enabled = true },

  -- COLORSCHEME
  { "folke/tokyonight.nvim",                       enabled = false },
  { "catppuccin/nvim",                             enabled = true },

  -- EDITOR
  -- fzf-lua
  { "ibhagwan/fzf-lua",                            enabled = true },
  -- neo-tree.nvim
  { "nvim-neo-tree/neo-tree.nvim",                 enabled = true },
  -- grug-far.nvim
  { "MagicDuck/grug-far.nvim",                     enabled = true },
  -- flash.nvim
  { "folke/flash.nvim",                            enabled = true },
  -- which-key.nvim
  { "folke/which-key.nvim",                        enabled = true },
  -- gitsigns.nvim
  { "lewis6991/gitsigns.nvim",                     enabled = true },
  -- trouble.nvim
  { "folke/trouble.nvim",                          enabled = true },
  -- todo-comments.nvim
  { "folke/todo-comments.nvim",                    enabled = true },

  -- FORMATTING
  -- conform.nvim
  { "stevearc/conform.nvim",                       enabled = true },
  -- mason.nvim
  -- WARNING: don't enable on NixOS
  { "mason.nvim",                                  enabled = true },

  -- LINTING
  -- nvim-lint
  { "mfussenegger/nvim-lint",                      enabled = true },

  -- LSP
  -- nvim-lspconfig
  { "neovim/nvim-lspconfig",                       enabled = true },
  -- WARNING: don't enable on NixOS
  { "williamboman/mason-lspconfig.nvim",           enabled = true },

  -- TREESITTER
  -- nvim-treesitter
  { "nvim-treesitter/nvim-treesitter",             enabled = true },
  { "nvim-treesitter/nvim-treesitter-textobjects", enabled = true },
  -- nvim-ts-autotag
  { "windwp/nvim-ts-autotag",                      enabled = true },

  -- UI
  -- bufferline.nvim
  { "akinsho/bufferline.nvim",                     enabled = true },
  -- lualine.nvim
  { "nvim-lualine/lualine.nvim",                   enabled = true },
  -- noice.nvim
  { "folke/noice.nvim",                            enabled = true },
  -- mini.icons
  { "echasnovski/mini.icons",                      enabled = true },
  -- nui.nvim
  { "MunifTanjim/nui.nvim",                        enabled = true },
  -- snacks.nvim
  { "folke/snacks.nvim",                           enabled = true },

  -- UTIL
  -- persistence.nvim
  { "folke/persistence.nvim",                      enabled = true },
  -- plenary.nvim
  { "nvim-lua/plenary.nvim",                       enabled = true },
}
