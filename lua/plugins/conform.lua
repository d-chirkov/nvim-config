vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
return {
	"stevearc/conform.nvim",
    event = "VeryLazy",
	opts = {
		default_format_opts = {
			async = false,
			timeout_ms = 10000,
		},
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			kotlin = { "ktlint" },
			java = { "google-java-format" },
			scala = { "scalafmt" },
			go = { "goimports", "gofmt" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
		},
		formatters = {
			shfmt = {
				append_args = { "-i", "2" },
			},
		},
	},
}
