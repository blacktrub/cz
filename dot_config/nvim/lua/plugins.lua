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
	{
		"neovim/nvim-lspconfig",
		-- dev = true,
		-- branch = "brieflang",
	},
	-- "terrortylor/nvim-comment",
	"ojroques/nvim-lspfuzzy",
	"junegunn/fzf",
	"junegunn/fzf.vim",
	"marko-cerovac/material.nvim",
	"bluz71/vim-nightfly-guicolors",
	{
		"bluz71/vim-nightfly-colors",
		name = "nightfly",
		lazy = false,
		priority = 1000,
	},
	"bluz71/vim-moonfly-colors",
	"folke/todo-comments.nvim",
	"blacktrub/neovim-typer",
	"kevinhwang91/nvim-bqf",
	"bhurlow/vim-parinfer",
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
	},
	"folke/neodev.nvim",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
	},
	"jay-babu/mason-null-ls.nvim",
	"jay-babu/mason-nvim-dap.nvim",
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"mfussenegger/nvim-dap-python",
	"leoluz/nvim-dap-go",
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
	{ "echasnovski/mini.ai", version = "*" },
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
	-- {
	-- 	"m4xshen/hardtime.nvim",
	-- 	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	-- 	opts = {
	-- 		disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil", "minifiles" },
	-- 	},
	-- },
	--
	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- We'd like this plugin to load first out of the rest
		config = true, -- This automatically runs `require("luarocks-nvim").setup()`
	},
	{
		"nvim-neorg/neorg",
		-- build = ":Neorg sync-parsers",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"vhyrro/luarocks.nvim",
		},
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					["core.export"] = {},
					["core.export.markdown"] = {},
					["core.concealer"] = {
						config = {
							folds = false,
							icon_preset = "diamond",
							init_open_folds = "never",
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
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				keymaps = {
					["yp"] = {
						desc = "Copy filepath to system clipboard",
						callback = function()
							require("oil.actions").copy_entry_path.callback()
							vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
						end,
					},
				},
			})
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
	{
		"stevearc/overseer.nvim",
		opts = {},
		config = function()
			require("overseer").setup({
				templates = {
					"builtin",
					"user.go_build",
					"user.go_test",
					"user.avito_lint",
				},
			})
		end,
	},
	{
		"yanskun/gotests.nvim",
		ft = "go",
		config = function()
			require("gotests").setup()
		end,
	},
	{
		"echasnovski/mini.align",
		version = "*",
		config = function()
			require("mini.align").setup()
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
	},
	{
		"shortcuts/no-neck-pain.nvim",
		version = "*",
	},
	{ "chrisgrieser/nvim-dr-lsp" },
	{
		"linrongbin16/gitlinker.nvim",
		config = function()
			require("gitlinker").setup({
				router = {
					browse = {
						["^stash%.msk%.avito%.ru"] = require("gitlinker.routers").bitbucket_browse,
					},
				},
			})
		end,
	},
	{
		"nvim-pack/nvim-spectre",
		config = function()
			require("spectre").setup()
			vim.keymap.set("n", "<leader>ss", '<cmd>lua require("spectre").toggle()<CR>', {
				desc = "Toggle Spectre",
			})
		end,
	},
	{
		"ggandor/leap.nvim",
		lazy = false,
	},
	{
		"nvim-neotest/nvim-nio",
	},
	{
		"catlee/pull_diags.nvim",
		event = "LspAttach",
		opts = {},
	},
	-- {
	-- 	"https://github.com/fresh2dev/zellij.vim.git",
	-- 	lazy = false,
	-- },
	"mechatroner/rainbow_csv",
}
