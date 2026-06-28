return {
	"OXY2DEV/markview.nvim",
    event = "VeryLazy",
	dependencies = {
		"saghen/blink.cmp",
	},
	opts = {
		preview = {
			filetypes = { "markdown", "md", "rmd", "quarto" },
			ignore_buftypes = { "nofile", "terminal", "prompt" },
		},
	},
}
