-- ensures that language servers are installed by mason
return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	event = "VeryLazy",
	dependencies = { "mason-org/mason.nvim" },
	opts = {
		ensure_installed = {
            -- most lsp is managed in mason-lspconfig.nvim.lua
            -- lsp
            "jdtls",
            "kotlin_lsp",
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
