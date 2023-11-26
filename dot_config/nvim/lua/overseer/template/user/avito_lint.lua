return {
	name = "avito lint",
	builder = function()
		return {
			cmd = { "avito", "lint" },
			components = { { "on_output_quickfix", open = true }, "default" },
		}
	end,
	condition = {
		filetype = { "go" },
	},
}
