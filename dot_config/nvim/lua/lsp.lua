require("neoconf").setup()

-- local servers = { "gopls", "pyright", "spectral", "html", "dockerls", "tsserver", "lua_ls", "sqlls" }
local servers = { "gopls", "pyright", "spectral", "html", "dockerls", "ts_ls", "lua_ls", "intelephense" }
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = servers,
})

require("neodev").setup({
	library = { plugins = { "nvim-dap-ui" }, types = true },
})

local sign_cfg = {
	bind = true,
	floating_window = false,
}

-- local nvim_lsp = require("lspconfig")
local lsp_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	require("lsp_signature").on_attach(sign_cfg, bufnr)

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	local function on_list(options)
		local new_options = { title = options.title, context = options.context }
		local items = {}
		local cur = 1
		for _, value in pairs(options.items) do
			if not string.find(value.filename, "mocks") then
				items[cur] = value
				cur = cur + 1
			end
		end
		new_options.items = items

		vim.fn.setqflist({}, " ", new_options)
		if #new_options.items > 1 then
			vim.api.nvim_command("copen")
		else
			vim.api.nvim_command("cfirst")
		end
	end

	vim.keymap.set("n", "gi", function()
		vim.lsp.buf.implementation({ on_list = on_list })
	end, { noremap = true, silent = true, buffer = bufnr })

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	buf_set_keymap("n", "gu", "<cmd>lua vim.lsp.buf.incoming_calls()()<CR>", opts)
end

vim.keymap.set("n", "<C-f>", function()
	vim.lsp.buf.format({ timeout = 2000 })
end, { noremap = true, silent = true })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

for i = 1, #servers do
	-- we init it below because of some custom attributes
	if servers[i] == "lua_ls" then
		goto continue
	end

	if servers[i] == "gopls" then
		goto continue
	end

	vim.lsp.config(servers[i], {
		on_attach = lsp_attach,
		flags = {
			debounce_text_changes = 150,
		},
		capabilities = capabilities,
	})
	vim.lsp.enable(servers[i])

	--nvim_lsp[servers[i]].setup({
	--	on_attach = lsp_attach,
	--	flags = {
	--		debounce_text_changes = 150,
	--	},
	--	capabilities = capabilities,
	--})
	::continue::
end

-- vim.lsp.config.lua_ls.setup({
-- 	settings = {
-- 		Lua = {
-- 			completion = {
-- 				callSnippet = "Replace",
-- 			},
-- 		},
-- 	},
-- 	on_attach = lsp_attach,
-- 	flags = {
-- 		debounce_text_changes = 150,
-- 	},
-- 	capabilities = capabilities,
-- })

vim.lsp.config("gopls",{
	on_attach = lsp_attach,
	-- flags = {
	-- 	debounce_text_changes = 150,
	-- },
	settings = {
		gopls = {
			buildFlags = { "-tags=integration" },
		},
		go = {
			completion = {
				callSnippet = "Replace",
			},
		},
	},
	capabilities = capabilities,
	-- capabilities = {
	-- 	workspace = {
	-- 		didChangeWatchedFiles = {
	-- 			dynamicRegistration = true,
	-- 		},
	-- 	},
	-- },
})
vim.lsp.enable("gopls")

-- add briefls
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

if not configs.briefls then
	configs.briefls = {
		default_config = {
			cmd = { "briefls" },
			-- cmd = { "nc", "127.0.0.1", "8833" },
			filetypes = { "brief" },
			root_dir = function(fname)
				return util.root_pattern(".git")(fname)
			end,
			single_file_support = true,
			capabilities = {
				workspace = {
					didChangeWatchedFiles = {
						dynamicRegistration = true,
					},
				},
			},
		},
		settings = {},
	}
end

-- setup briefls
vim.lsp.config("briefls", {
	on_attach = lsp_attach,
	flags = {
		debounce_text_changes = 150,
	},
	capabilities = capabilities,
})
vim.lsp.enable("briefls")
-- nvim_lsp.briefls.setup({
-- 	on_attach = lsp_attach,
-- 	flags = {
-- 		debounce_text_changes = 150,
-- 	},
-- 	capabilities = capabilities,
-- 	init_options = {
-- 		-- auth = {
-- 		-- 	{
-- 		-- 		provider = "paas-api",
-- 		-- 		token = "token",
-- 		-- 		expires_in = 100,
-- 		-- 	},
-- 		-- },
-- 	},
-- })

-- vim.lsp.set_log_level("debug")
