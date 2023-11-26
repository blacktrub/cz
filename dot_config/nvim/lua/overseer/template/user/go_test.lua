return {
	name = "go test",
	builder = function()
		return {
			cmd = { "go", "test", "-v", "./..." },
			components = { { "on_output_quickfix", open = true }, "default" },
		}
	end,
	condition = {
		filetype = { "go" },
	},
}
