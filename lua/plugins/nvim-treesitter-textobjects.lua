return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("nvim-treesitter.configs").setup({
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
					},
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						["@class.outer"] = "<c-v>", -- blockwise
					},
					include_surrounding_whitespace = true,
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]gf"] = "@function.outer",
						["]gc"] = "@class.outer",
					},
					goto_next_end = {
						["]gF"] = "@function.outer",
						["]gC"] = "@class.outer",
					},
					goto_previous_start = {
						["[gf"] = "@function.outer",
						["[gc"] = "@class.outer",
					},
					goto_previous_end = {
						["[gF"] = "@function.outer",
						["[gC"] = "@class.outer",
					},
				},
			},
		})
	end,
}
