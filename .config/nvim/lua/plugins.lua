return {
	"j-hui/fidget.nvim",
    "neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	{
		'nvim-lualine/lualine.nvim',
		dependencies = {
			'nvim-tree/nvim-web-devicons'
		},
		config = function()
			require('lualine').setup({
				icons_enabled = true,
				theme = 'nord',
			})
		end
	},
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		'shaunsingh/nord.nvim',
		priority = 1000,
		config = function() 
			vim.cmd("colorscheme nord")
		end
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			'rafamadriz/friendly-snippets',
			'hrsh7th/cmp-nvim-lsp',
		},
	},
	{
	  "nvim-tree/nvim-tree.lua",
	  version = "*",
	  lazy = false,
	  dependencies = {
		"nvim-tree/nvim-web-devicons",
	  },
	  config = function()
		require("nvim-tree").setup {}
	  end,
	},
	"easymotion/vim-easymotion",
	"junegunn/fzf.vim",
	"junegunn/fzf",
	"tpope/vim-fugitive",
	{
		'lewis6991/hover.nvim',
		config = function()
			require('hover').setup {
				init = function()
					require("hover.providers.lsp")
				end
			}

			vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
			vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})
			vim.keymap.set("n", "<C-p>", function() require("hover").hover_switch("previous") end, {desc = "hover.nvim (previous source)"})
			vim.keymap.set("n", "<C-n>", function() require("hover").hover_switch("next") end, {desc = "hover.nvim (next source)"})
			vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = "hover.nvim (mouse)" })
			vim.o.mousemoveevent = true
		end
	},
}

