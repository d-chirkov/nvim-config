return {
	"ibhagwan/fzf-lua",
	enabled = true,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
    priority = 1002,
	config = function()
		local fzf = require("fzf-lua")
		local file_history = vim.fn.stdpath("data") .. "/fzf-lua-file-history.txt"
		local grep_history = vim.fn.stdpath("data") .. "/fzf-lua-grep-history.txt"
		local history_size = "1000"
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
				border = "border-top",
				title_pos = "left",
				preview = {
					border = "none",
					layout = "vertical",
					vertical = "up:50%",
				},
			},
			oldfiles = {
				true,
				include_current_session = true,
				no_ignore = false,
				fzf_opts = {
					["--history"] = file_history,
				},
			},
			files = {
				true,
				no_ignore = false,
				fzf_opts = {
					["--history"] = file_history,
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
					-- filter toggles
					-- tests
					["alt-t"] = 'transform-query(echo {q} | awk \'{if($0 ~ /(^| )!test( |$)/){gsub(/(^| )!test( |$)/," "); gsub(/^ /,""); gsub(/ $/,"")}else{$0="!test "$0}; print}\')',
					-- kotlin files
					["alt-k"] = 'transform-query(echo {q} | awk \'{if($0 ~ /(^| )\\047.kt( |$)/){gsub(/(^| )\\047.kt( |$)/," "); gsub(/^ /,""); gsub(/ $/,"")}else{$0="\\047.kt "$0}; print}\')',
					-- scala files
					["alt-s"] = 'transform-query(echo {q} | awk \'{if($0 ~ /(^| )\\047.scala( |$)/){gsub(/(^| )\\047.scala( |$)/," "); gsub(/^ /,""); gsub(/ $/,"")}else{$0="\\047.scala "$0}; print}\')',
					-- java files
					["alt-j"] = 'transform-query(echo {q} | awk \'{if($0 ~ /(^| )\\047.java( |$)/){gsub(/(^| )\\047.java( |$)/," "); gsub(/^ /,""); gsub(/ $/,"")}else{$0="\\047.java "$0}; print}\')',
				},
			},
		})
	end,
}
