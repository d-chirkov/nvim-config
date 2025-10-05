vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		default_format_opts = {
			async = false,
			timeout_ms = 10000,
		},
		-- log_level = vim.log.levels.DEBUG,
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
