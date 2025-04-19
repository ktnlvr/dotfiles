require('core')

-- Yaaay plugins
require "paq" {
    "savq/paq-nvim",
    "neovim/nvim-lspconfig", 

    "williamboman/mason.nvim", -- LSP Manager

    "folke/which-key.nvim", -- Add hints for keys
 
    'nvim-lua/plenary.nvim', -- Dependency for telescope, hop and neogit
    'nvim-telescope/telescope.nvim',

    'rafamadriz/friendly-snippets', -- Dependency for blink.cmp
    'saghen/blink.cmp',

    { "lervag/vimtex", opt = true },
    { "smoka7/hop.nvim", branch = "v2.7.2" },
    "NeogitOrg/neogit",

    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    { 'nvim-treesitter/playground' },

    "nyoom-engineering/oxocarbon.nvim",

    "vimwiki/vimwiki", -- Notes/Productivity Yaaay

    "nvim-tree/nvim-tree.lua", -- File Tree View
    "lewis6991/gitsigns.nvim", -- Line-by-line Blame/Diff
}

vim.opt.background = "dark"
vim.cmd.colorscheme("oxocarbon")

require('nvim-tree').setup()

require('blink.cmp').setup({
    signature = { enabled = true },
    keymap = { preset = 'default' },
    appearance = {
        nerd_font_variant = 'mono'
    },
    completion = { documentation = { auto_show = false } },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "lua" }
})

require('gitsigns').setup({ word_diff = true, current_line_blame = true })

require('basic')

