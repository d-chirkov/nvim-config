return {
	"f-person/auto-dark-mode.nvim",
	event = "VeryLazy",
	priority = 1001,
	opts = {
		set_dark_mode = function()
			vim.api.nvim_set_option_value("background", "dark", {})
            vim.cmd([[
                hi TreesitterContextBottom gui=underline guisp=Grey
                hi TreesitterContextLineNumberBottom gui=underline guisp=Grey
                hi CursorLine guibg=#292929
            ]])
		end,
		set_light_mode = function()
			vim.api.nvim_set_option_value("background", "light", {})
            vim.cmd([[
                hi TreesitterContextBottom gui=underline guisp=Grey
                hi TreesitterContextLineNumberBottom gui=underline guisp=Grey
            ]])
		end,
		update_interval = 3000,
		fallback = "dark",
	},
}
