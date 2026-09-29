return {
	"OXY2DEV/markview.nvim",
	event = "VeryLazy",
	cmd = "Markview",
	dependencies = {
		"saghen/blink.cmp",
	},
	opts = {
		preview = {
			enable = false,
			filetypes = { "markdown", "md", "rmd", "quarto" },
			ignore_buftypes = { "nofile", "terminal", "prompt" },
		},
	},
}
