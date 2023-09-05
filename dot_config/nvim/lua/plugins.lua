return {
	"nvim-lualine/lualine.nvim",
	"kyazdani42/nvim-web-devicons",
	{
		"kyazdani42/nvim-tree.lua",
	},
	"goolord/alpha-nvim",
	"akinsho/toggleterm.nvim",
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"neovim/nvim-lspconfig",
	"terrortylor/nvim-comment",
	"ojroques/nvim-lspfuzzy",
	"junegunn/fzf",
	"junegunn/fzf.vim",
	"marko-cerovac/material.nvim",
	"bluz71/vim-nightfly-guicolors",
	"bluz71/vim-moonfly-colors",
	"folke/todo-comments.nvim",
	"blacktrub/neovim-typer",
	"kevinhwang91/nvim-bqf",
	"bhurlow/vim-parinfer",
	"folke/trouble.nvim",
	"folke/neodev.nvim",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"jose-elias-alvarez/null-ls.nvim",
	"jay-babu/mason-null-ls.nvim",
	"jay-babu/mason-nvim-dap.nvim",
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"mfussenegger/nvim-dap-python",
	"leoluz/nvim-dap-go",
	"ThePrimeagen/harpoon",
	"APZelos/blamer.nvim",
	"chentoast/marks.nvim",
	"sindrets/diffview.nvim",
	"ray-x/lsp_signature.nvim",
	"EdenEast/nightfox.nvim",
	"folke/tokyonight.nvim",
	"folke/neoconf.nvim",
	{ "blacktrub/stay-centered.nvim" },
	{ "echasnovski/mini.move", version = "*" },
	{ "echasnovski/mini.splitjoin", version = "*" },
	{ "blacktrub/telescope-godoc.nvim", dev = true },
	{ "phaazon/hop.nvim", branch = "v2" },
	{
		"L3MON4D3/LuaSnip",
		version = "1.2.*",
		build = "make install_jsregexp",
	},
	{ "hrsh7th/nvim-cmp" },
	"hrsh7th/cmp-nvim-lsp",
	{ "saadparwaiz1/cmp_luasnip" },
	{ "echasnovski/mini.pairs", version = "*" },
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil", "minifiles" },
		},
	},
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					["core.concealer"] = {
						config = {
							folds = false,
							icon_preset = "diamond",
						},
					}, -- Adds pretty icons to your documents
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								notes = "~/notes",
							},
							default_workspace = "notes",
						},
					},
					["core.keybinds"] = {
						config = {
							hook = function(keybinds)
								keybinds.remap_key("norg", "n", "<M-CR>", "<C-CR>")
							end,
						},
					},
				},
			})
		end,
	},
	-- { "echasnovski/mini.files", version = false },
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup()
		end,
	},
	{
		"echasnovski/mini.misc",
		version = false,
		lazy = false,
		config = function()
			local misc = require("mini.misc")
			misc.setup({
				make_global = { "setup_auto_root" },
			})
			misc.setup_auto_root({ ".git", "init.lua", "Makefile" })
		end,
	},
}
