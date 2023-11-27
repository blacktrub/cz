return {
	name = "avito lint",
	builder = function()
		return {
			cmd = { "avito", "lint" },
			components = { { "on_complete_notify" }, "default" },
		}
	end,
	condition = {
		filetype = { "go" },
	},
}
