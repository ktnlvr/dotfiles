require('core')

-- Yaaay plugins
require "paq" {
    "savq/paq-nvim",
    "neovim/nvim-lspconfig", 

    "williamboman/mason.nvim", -- LSP Manager

    "folke/which-key.nvim", -- Add hints for keys
 
    'nvim-lua/plenary.nvim', -- Dependency for telescope, hop and neogit
    'nvim-telescope/telescope.nvim',

    { "lervag/vimtex", opt = true },
    { "phaazon/hop.nvim", branch = "v2" },
    "NeogitOrg/neogit",

    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    { 'nvim-treesitter/playground' },

    "nyoom-engineering/oxocarbon.nvim",
}

vim.opt.background = "dark"
vim.cmd.colorscheme("oxocarbon")

require('basic')
