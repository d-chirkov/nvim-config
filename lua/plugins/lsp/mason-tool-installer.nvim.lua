-- ensures that language servers are installed by mason
return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	event = "VeryLazy",
	dependencies = { "williamboman/mason.nvim" },
	opts = {
		ensure_installed = {
            -- lsp
			"gopls",
			"kotlin-lsp",
			"jdtls",
			"json-lsp",
			"marksman",
            "docker-language-server",
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
