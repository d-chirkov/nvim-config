local file_history = vim.fn.stdpath("data") .. "/fzf-lua-file-history.txt"
local grep_history = vim.fn.stdpath("data") .. "/fzf-lua-grep-history.txt"
local history_size = "1000"

return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		require("fzf-lua").setup({
			{ "hide" },
			fzf_opts = {
				["--history"] = grep_history,
				["--history-size"] = history_size,
			},
			grep = {
				true,
				rg_glob = true,
				glob_flag = "--iglob",
				glob_separator = "%s%-%-",
				no_ignore = false,
				hidden = true,
			},
			live_grep = {
				true,
			},
			winopts = {
				true,
				fullscreen = true,
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
				fzf_opts = {
					["--history"] = grep_history,
					--["--history"] = file_history,
				},
			},
			files = {
				true,
				no_ignore = false,
				fzf_opts = {
					--["--history"] = file_history,
					["--history"] = grep_history,
				},
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
					["ctrl-p"] = "prev-history",
					["ctrl-n"] = "next-history",
				},
			},
		})
	end,
}
