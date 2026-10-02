return {
	"xb-bx/editable-term.nvim",
	config = function()
		require("editable-term").setup({
			promts = {
				["^%d%d:%d%d:%d%d> "] = {},
			},
		})
	end,
}
