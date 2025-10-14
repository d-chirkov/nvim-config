return {
	"lewis6991/gitsigns.nvim",
    event = "VeryLazy",
	cond = function()
		return vim.fs.find(".git", { upward = true })[1] ~= nil
	end,
}
