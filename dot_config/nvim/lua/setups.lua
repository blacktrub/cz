require("lualine").setup({
	options = { theme = "nightfly" },
	sections = {
		lualine_a = {
			{
				"filename",
				file_status = true, -- displays file status (readonly status, modified status)
				path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
			},
		},
		lualine_c = {
			{ require("dr-lsp").lspCount },
			{ require("dr-lsp").lspProgress },
		},
	},
})

require("nvim-web-devicons").get_icons()
require("alpha").setup(require("alpha.themes.startify").opts)

-- require("nvim-tree").setup({
-- 	disable_netrw = true,
-- 	hijack_netrw = true,
-- 	-- auto_close          = true,
-- 	open_on_tab = true,
-- 	hijack_cursor = false,
-- 	update_cwd = false,
-- 	hijack_directories = {
-- 		enable = true,
-- 		auto_open = true,
-- 	},
-- 	diagnostics = {
-- 		enable = false,
-- 		icons = {
-- 			hint = "",
-- 			info = "",
-- 			warning = "",
-- 			error = "",
-- 		},
-- 	},
-- 	update_focused_file = {
-- 		enable = false,
-- 		update_cwd = false,
-- 		ignore_list = {},
-- 	},
-- 	system_open = {
-- 		cmd = nil,
-- 		args = {},
-- 	},
-- 	filters = {
-- 		dotfiles = false,
-- 		custom = {},
-- 	},
-- 	view = {
-- 		width = 60,
-- 		hide_root_folder = false,
-- 		side = "left",
-- 		mappings = {
-- 			custom_only = false,
-- 			list = {},
-- 		},
-- 	},
-- })

require("toggleterm").setup({
	open_mapping = [[<c-p>]],
	shade_filetypes = {},
	shade_terminals = true,
	start_in_insert = true,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	persist_size = true,
	direction = "float",
	close_on_exit = true, -- close the terminal window when the process exits
	shell = vim.o.shell, -- change the default shell
	float_opts = {
		border = "single",
	},
})

require("telescope").setup({
	defaults = {
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		file_ignore_patterns = { "vendor" },
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				-- even more opts
			}),
		},
	},
})
require("telescope").load_extension("ui-select")
-- require("telescope").load_extension("godoc")

local treesitter_languages = {
	"lua",
	"vim",
	"go",
	"gomod",
	"gosum",
	"python",
	"yaml",
}
require("nvim-treesitter.configs").setup({
	ensure_installed = treesitter_languages,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
	},
})

local luasnip = require("luasnip")
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	preselect = cmp.PreselectMode.None,
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-y>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			{ "i", "l" }
		),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = function(fallback)
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "path" },
	},
	-- completion = {
	-- completeopt = "menu,menuone,noselect",
	-- completeopt = "menu,menuone",
	-- },
})

-- require("nvim_comment").setup()
require("todo-comments").setup({})
require("bqf").setup()
require("trouble").setup()
require("marks").setup()
-- require("stay-centered").setup({
-- 	skip_buftypes = { "terminal", "quickfix" },
-- })

require("mini.move").setup()
require("mini.splitjoin").setup()

require("godoc")

require("hop").setup()

require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" })
require("mini.pairs").setup()
-- require("hardtime").setup()

-- Setup pwd when open nvim with PATH args
if vim.fn.argc(-1) > 0 then
	local path = vim.fn.argv(0)
	if path:find("^oil://") then
		path = path:gsub("^oil://", "")
	end

	if vim.fn.isdirectory(path) == 0 then
		path = vim.fs.dirname(path)
	end

	vim.fn.chdir(path)
end

require("no-neck-pain").setup({
	width = 180,
	autocmds = {
		enableOnVimEnter = true,
	},
	integrations = {
		NvimDAPUI = {
			position = "none",
			reopen = true,
		},
	},
})

local leap = require("leap")
leap.opts.max_phase_one_targets = 2
