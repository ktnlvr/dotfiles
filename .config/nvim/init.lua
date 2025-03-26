require('core')

-- Yaaay plugins
require "paq" {
    "savq/paq-nvim",
    "neovim/nvim-lspconfig", 

    { 'nvim-lua/plenary.nvim' }, -- Dependency for telescope
    { 'nvim-telescope/telescope.nvim' },

    { "lervag/vimtex", opt = true },

    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    { 'nvim-treesitter/playground' },
}

require('remap')
