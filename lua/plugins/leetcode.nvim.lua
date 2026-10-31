return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	dependencies = {
		"ibhagwan/fzf-lua",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		picker = { provider = "fzf-lua" },
		lang = "java",
		storage = {
			home = vim.fn.expand("~/projects/leetcode"),
			cache = vim.fn.stdpath("cache") .. "/leetcode",
		},
	},
}
