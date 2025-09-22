-- bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- load lazy.nvim
require("lazy").setup({
  spec = {
  -- Core LazyVim (this is what provides lazyvim.plugins)
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- Your custom plugins
    {
      "neovim/nvim-lspconfig",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "nvimtools/none-ls.nvim",
      "nvim-treesitter/nvim-treesitter",
    },

  },

  defaults = {
    lazy = true,
    version = "*",
  },

  install = {
    colorscheme = { "catppuccin" },
  },

  checker = { enabled = true },
})
