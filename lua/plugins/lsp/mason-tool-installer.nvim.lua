-- ensures that language servers are installed by mason
return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "williamboman/mason.nvim" },
	opts = {
		ensure_installed = {
			"gopls",
			"kotlin-lsp",
			"jdtls",
			"json-lsp",
			"marksman",
			-- formatter
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
