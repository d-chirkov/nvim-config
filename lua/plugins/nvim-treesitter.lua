return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				"c",
				"cpp",
				"go",
				"lua",
				"python",
				"rust",
				"typescript",
				"cmake",
				"kotlin",
				"java",
				"bash",
				"dockerfile",
				"markdown",
				"make",
				"kotlin",
				"markdown_inline",
				"html",
				"latex",
				"typst",
				"yaml",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		})
	end,
}
