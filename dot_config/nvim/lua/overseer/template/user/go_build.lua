return {
	name = "go build",
	builder = function()
		-- Full path to current file (see :help expand())
		--vim.fn.getcwd()
		return {
			cmd = { "go", "build", "-o", "bin/", "./..." },
			components = { { "on_output_quickfix", open = true }, "default" },
		}
	end,
	condition = {
		filetype = { "go" },
	},
}
