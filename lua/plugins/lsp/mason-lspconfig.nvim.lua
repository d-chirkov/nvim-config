return {
	"mason-org/mason-lspconfig.nvim",
	opts = {},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	config = function()
		vim.lsp.config("gopls", {
			cmd = { "gopls" },
			settings = { gopls = { staticcheck = true } },
			root_markers = { "go.work", "go.mod", ".git" },
		})

		vim.lsp.config("jdtls", {
			cmd_env = {
				JAVA_HOME = os.getenv("JAVA_HOME_21"),
			},
			settings = {
				java = {},
			},
			root_dir = vim.fs.root(0, { "gradlew", ".git", "mvnw" }),
		})

		vim.lsp.config("rust_analyzer", {
			settings = {
				["rust-analyzer"] = {},
			},
			root_markers = { ".git", "Cargo.toml" },
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in Neovim)
						version = "LuaJIT",
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global and other Neovim globals
						globals = { "vim", "use", "Plug", "before_each", "after_each", "describe", "it" },
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = { vim.env.VIMRUNTIME },
						checkThirdParty = false, -- Disable checking of third-party libraries by default for performance
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})

		-- kotlin added via plugin
		-- java (jdtls) is configured via plugin
		-- scala (metals) is configured via plugin
		-- rust - install locally: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
		require("mason-lspconfig").setup({
			ensure_installed = {
				--"gopls", # Mason has invalid gopls package, installed locally via brew
				--"jdtls",
				--"kotlin_lsp",
				"jsonls",
				"marksman",
				"rust_analyzer",
				"lua_ls",
			},
			automatic_enable = {
				-- list disabled language servers
				exclude = {
					"gopls",
                    "kotlin_lsp",
				},
			},
		})

		vim.lsp.enable("gopls")
	end,
}
