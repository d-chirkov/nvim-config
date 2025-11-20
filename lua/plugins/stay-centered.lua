return {
	"arnamak/stay-centered.nvim",
	event = "VeryLazy",
	config = function()
		require("stay-centered").setup({
			skip_filetypes = {""},
			enabled = true,
			allow_scroll_move = true,
			disable_on_mouse = false,
		})
	end,
}
