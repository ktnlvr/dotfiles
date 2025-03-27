require('core')

-- Yaaay plugins
require "paq" {
    "savq/paq-nvim",
    "neovim/nvim-lspconfig", 

    'nvim-lua/plenary.nvim', -- Dependency for telescope, hop and neogit
    'nvim-telescope/telescope.nvim',

    { "lervag/vimtex", opt = true },
    { "phaazon/hop.nvim", branch = "v2" },
    "NeogitOrg/neogit",

    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    { 'nvim-treesitter/playground' },
}

require('remap')
