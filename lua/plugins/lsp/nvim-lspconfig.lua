-- configures language servers
return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.lsp.config("gopls", {
			settings = { gopls = { staticcheck = true } },
			root_markers = { "go.work", "go.mod", ".git" },
		})

		vim.lsp.config("jdtls", {
			cmd_env = {
				JAVA_HOME = "/Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home",
			},
			settings = {
				java = {},
			},
		})

		-- kotlin added via plugin
		-- jdtls is configured via plugin
		vim.lsp.enable({
			"gopls",
			"jdtls",
			"jsonls",
			"marksman",
		})
	end,
}
