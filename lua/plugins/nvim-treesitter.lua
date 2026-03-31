return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup()
		require("nvim-treesitter").install({
			"bash", "c", "cmake", "cpp", "dockerfile", "go", "html", "java",
			"javascript", "kotlin", "latex", "lua", "make", "markdown",
			"markdown_inline", "proto", "python", "rust", "typescript", "typst",
			"yaml", "c_sharp", "comment", "css", "csv", "diff", "editorconfig",
			"gitignore", "hocon", "http", "hurl", "ini", "javadoc", "json",
			"luadoc", "regex", "scala", "sql", "vim", "vimdoc", "xml",
		})
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
			end,
		})
	end,
}
