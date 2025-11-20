-- configures language servers
return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
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
			root_dir = vim.fs.root(0, { "gradlew", ".git", "mvnw" }),
		})

		vim.lsp.config("docker_language_server", {})

		-- kotlin added via plugin
		-- java (jdtls) is configured via plugin
		-- scala (metals) is configured via plugin
		vim.lsp.enable({
			"gopls",
			"jdtls",
			"jsonls",
			"marksman",
			"docker_language_server",
		})
	end,
}
