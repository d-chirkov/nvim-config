return {
	"Mofiqul/vscode.nvim",
    enabled = true,
	opts = {
		transparent = true,
		italic_comments = true,
		--disable_nvimtree_bg = true,
		color_overrides = {
			vscLineNumber = "#b8b8b8",
		},
		group_overrides = {
			--CursorLine = { bg='#dcdcdc' },
			--MatchParen = { bg='#c0c0c0'},
		},
	},
	config = function()
		vim.cmd.colorscheme("vscode")
	end,
}
