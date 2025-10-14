return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
	opts = {
        { "hide" },
		grep = {
			true,
			rg_glob = true,
			glob_flag = "--iglob",
			glob_separator = "%s%-%-",
			no_ignore = false,
            hidden = true,
		},
		winopts = {
			true,
			height = 0.90,
			width = 0.95,
			preview = {
				layout = "vertical",
			},
		},
		oldfiles = {
			true,
			include_current_session = true,
			no_ignore = false,
		},
		files = {
			true,
			no_ignore = false,
		},
		keymap = {
			true,
			fzf = {
				true,
				["ctrl-j"] = "half-page-down",
				["ctrl-k"] = "half-page-up",
				["ctrl-h"] = "beginning-of-line",
				["ctrl-l"] = "end-of-line",
				["alt-a"] = "toggle-all",
			},
		},
	},
}
