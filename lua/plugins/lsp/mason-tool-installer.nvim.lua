-- ensures that language servers are installed by mason
return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	event = "VeryLazy",
	dependencies = { "williamboman/mason.nvim" },
	opts = {
		ensure_installed = {
            -- lsp is managed in mason-lspconfig.nvim.lua
			-- formatters
			"black",
			"stylua",
			"ktlint",
			"google-java-format",
			"prettier",
            "goimports",
            "isort",
		},
		run_on_start = true,
	},
}
