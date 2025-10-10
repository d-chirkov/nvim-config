return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "FzfLua",
	opts = {
		"hide",
		grep = {
			true,
			rg_glob = true,
			glob_flag = "--iglob",
			glob_separator = "%s%-%-",
			no_ignore = false,
		},
		winopts = {
			true,
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
		actions = {
			files = {
				["default"] = function(...)
					return require("fzf-lua.actions").file_edit(...)
				end,
				["ctrl-n"] = function(...)
					return require("fzf-lua.actions").file_tabedit(...)
				end,
				["ctrl-t"] = false,
			},
			buffers = {
				["default"] = function(...)
					return require("fzf-lua.actions").buf_edit(...)
				end,
				["ctrl-n"] = function(...)
					return require("fzf-lua.actions").buf_tabedit(...)
				end,
				["ctrl-t"] = false,
			},
			grep = {
				["default"] = function(...)
					return require("fzf-lua.actions").grep_edit(...)
				end,
				["ctrl-n"] = function(...)
					return require("fzf-lua.actions").grep_tabedit(...)
				end,
				["ctrl-t"] = false,
			},
			oldfiles = {
				["default"] = function(...)
					return require("fzf-lua.actions").file_edit(...)
				end,
				["ctrl-n"] = function(...)
					return require("fzf-lua.actions").file_tabedit(...)
				end,
				["ctrl-t"] = false,
			},
		},
	},
}
