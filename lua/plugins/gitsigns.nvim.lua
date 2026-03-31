return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	cond = function()
		return vim.fs.find(".git", { upward = true })[1] ~= nil
	end,
	config = function()
		local obj = vim.system({ "git", "symbolic-ref", "refs/remotes/origin/HEAD" }, { text = true }):wait()
		local base = obj.code == 0 and vim.trim(obj.stdout):gsub("refs/remotes/", "") or "master"
		require("gitsigns").setup({
			base = base,
		})
	end,
}
