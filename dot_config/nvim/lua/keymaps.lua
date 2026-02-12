local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "{", ":BufferPrevious<CR>", opts)
map("n", "}", ":BufferNext<CR>", opts)
map("n", "<C-c>", ":BufferClose<CR>", opts)
map("n", "<C-a>", ":BufferCloseAllButCurrent<CR>", opts)

map("n", "<C-n>", ":NvimTreeToggle<CR>", opts)
map("n", "<C-b>", ":NvimTreeFocus<CR>", opts)
map("n", "<leader>r", ":NvimTreeRefresh<CR>", opts)
map("n", "<leader>n", ":NvimTreeFindFile<CR>", opts)

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
map("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", opts)
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
map("n", "<leader>fm", "<cmd>Telescope marks<cr>", opts)
map("n", "<leader>fr", "<cmd>Telescope git_status<cr>", opts)

-- terminal: enter visual mode
map("t", "<esc>", "<C-\\><C-n>", opts)

map("v", "<C-s>t", "<Esc>:NvimTyper<cr>", opts)

map("n", "<leader>co", ":copen<cr>", opts)
map("n", "<leader>cc", ":ccl<cr>", opts)
map("n", "<leader>cn", ":cnext<cr>", opts)

map("n", "<leader>zb", ':lua require("dap").toggle_breakpoint()<cr>', opts)
map("n", "<leader>zc", ':lua require("dap").continue()<cr>', opts)
map("n", "<leader>zn", ':lua require("dap").step_over()<cr>', opts)
map("n", "<leader>zi", ':lua require("dap").step_in()<cr>', opts)
map("n", "<leader>zo", ':lua require("dap").step_out()<cr>', opts)
map("n", "<leader>zr", ':lua require("dap").run_last()<cr>', opts)
map("n", "<leader>zt", ':lua require("dapui").toggle()<cr>', opts)

-- movements
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

map("n", "<Space><Space>", ":wa<cr>", opts)

map("v", ";rv", 'c<C-O>:set revins<CR><C-R>"<Esc>:set norevins<CR>', opts)

map("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<CR>", opts)
vim.keymap.set("", "<leader>tn", function()
	require("trouble").next({ skip_groups = true, jump = true })
end, opts)

-- window motions remap
-- map('n', '<C-h>', '<C-w>h', opts)
-- map('n', '<C-j>', '<C-w>j', opts)
-- map('n', '<C-k>', '<C-w>k', opts)
-- map('n', '<C-l>', '<C-w>l', opts)

-- map('n', '<leader-c>', '\\cc', opts)
--

map("n", "gb", "<cmd>BlamerToggle<CR>", opts)

-- harpoon
-- NOTE: old harpoon
-- map("n", "<leader>a", '<cmd>lua require("harpoon.mark").add_file()<CR>', opts)
-- map("n", "<leader>l", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)
-- for i = 1, 5 do
-- 	map("n", "<leader>" .. i, '<cmd>:lua require("harpoon.ui").nav_file(' .. i .. ")<CR>", opts)
-- end

local harpoon = require("harpoon")
harpoon:setup({
	settings = {
		ui_fallback_width = 69,
		ui_width_ratio = 0.25,
		save_on_toggle = true,
		-- sync_on_ui_close = true,
	},
})

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end, opts)
vim.keymap.set("n", "<leader>l", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, opts)
for i = 1, 5 do
	vim.keymap.set("n", "<leader>" .. i, function()
		harpoon:list():select(i)
	end, opts)
end

--local hop = require("hop")
--local directions = require("hop.hint").HintDirection
--vim.keymap.set("", "f", function()
--	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
--end, opts)
---- vim.keymap.set("", "F", function()
---- 	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
---- end, opts)
--vim.keymap.set("", "t", function()
--	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
--end, opts)
---- vim.keymap.set("", "T", function()
---- 	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
---- end, opts)
--vim.keymap.set("", "<C-s>", function()
--	hop.hint_words()
--end, opts)
---- vim.keymap.set("", "<leader>s", function()
---- 	hop.hint_char1()
---- end, opts)
vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-backward)")
vim.keymap.set({ "n", "x", "o" }, "<leader>s", "<Plug>(leap-from-window)")

map("n", ";", ":", opts)
-- map("n", "-", ":lua MiniFiles.open()<CR>", {})
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

map("n", "<leader>bb", "<cmd>OverseerRun<CR>", opts)
map("n", "<leader>bt", "<cmd>OverseerToggle<CR>", opts)

-- vim.cmd("let g:zellij_navigator_no_default_mappings = 1")
-- vim.cmd("noremap <M-h> :ZellijNavigateLeft<CR>")
-- vim.cmd("noremap <M-h> :ZellijNavigateRight<CR>")
-- map("n", "<M-j>", "<cmd>ZellijNavigateLeft<CR>", {})
-- map("n", "<M-l>", "<cmd>ZellijNavigateRight<CR>", {})

map("n", "<leader>o", "o<Esc>k", opts)
map("n", "<leader>O", "O<Esc>j", opts)
