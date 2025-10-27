return {
	"folke/snacks.nvim",
    enabled = false,
	opts = {
		picker = {
            limit_live = 100000,
			layout = {
				preset = "ivy_split",
			},
			win = {
				input = {
					keys = {
						--["<Esc>"] = { "close", mode = { "n", "i" } },
                        ["<C-n>"] = { "history_forward", mode = { "i", "n" } },
                        ["<C-p>"] = { "history_back", mode = { "i", "n" } },
					},
				},
			},
		},
	},
	keys = {
		{
			"<leader>k",
			function()
				Snacks.picker.smart({
					multi = { "recent", "files" },
					format = "file",
					filter = {
						cwd = true,
					},
					matcher = {
						sort_empty = false,
						frecency = false,
						history_bonus = true,
					},
					transform = "unique_file",
				})
			end,
			desc = "files",
		},
		{
			"<leader>k",
			function()
				Snacks.picker.smart({
					pattern = function(picker)
						return picker:word()
					end,
					multi = { "recent", "files" },
					format = "file",
					filter = {
						cwd = true,
					},
					matcher = {
						sort_empty = false,
						frecency = false,
						history_bonus = true,
					},
					transform = "unique_file",
				})
			end,
			desc = "files: visual",
			mode = { "x" },
		},
		{
			"<leader>K",
			function()
				Snacks.picker.smart({
					pattern = function(picker)
						return picker:word()
					end,
					multi = { "recent", "files" },
					format = "file",
					filter = {
						cwd = true,
					},
					matcher = {
						sort_empty = false,
						frecency = false,
						history_bonus = true,
					},
					transform = "unique_file",
				})
			end,
			desc = "files: visual",
		},
		{
			"<leader>j",
			function()
				Snacks.picker.grep({
					finder = "grep",
					regex = false,
					format = "file",
					show_empty = true,
					live = true,
					supports_live = true,
				})
			end,
			desc = "grep",
		},
		{
			"<leader>j",
			function()
				Snacks.picker.grep({
					finder = "grep",
					regex = false,
					format = "file",
					show_empty = true,
					live = true,
					supports_live = true,
					search = function(picker)
						return picker:word()
					end,
				})
			end,
			desc = "grep: visual",
			mode = { "x" },
		},
		{
			"<leader>J",
			function()
				Snacks.picker.grep({
					finder = "grep",
					regex = false,
					format = "file",
					show_empty = true,
					live = true,
					supports_live = true,
					search = function(picker)
						return picker:word()
					end,
				})
			end,
			desc = "grep: visual",
		},
		{
			"<leader>y",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "lsp: type",
		},
		{
			"<leader>u",
			function()
				Snacks.picker.lsp_references()
			end,
			desc = "lsp: references",
		},
		{
			"<leader>i",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "lsp: implementation",
		},
		{
			"<leader>d",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "lsp: definitions",
		},
		{
			"<leader>l",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},
		{
			"<leader>l",
			function()
				Snacks.picker.lsp_workspace_symbols({
					search = function(picker)
						return picker:word()
					end,
				})
			end,
			desc = "LSP Workspace Symbols",
			mode = { "x" },
		},
		{
			"<leader>L",
			function()
				Snacks.picker.lsp_workspace_symbols({
					search = function(picker)
						return picker:word()
					end,
				})
			end,
			desc = "lsp workspace symbols",
		},
		{
			"<leader>;",
			function()
				Snacks.picker.resume()
			end,
			desc = "lsp workspace symbols",
		},
		{
			"<leader>n",
			function()
				Snacks.picker.lines()
			end,
			desc = "grep lines",
		},
		{
			"<leader>m",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "grep lines",
		},
		{
			"<leader>eh",
			function()
				Snacks.picker.git_log_file()
			end,
			desc = "pickers",
		},
		{
			"<leader>ef",
			function()
				Snacks.picker.pickers()
			end,
			desc = "pickers",
		},
	},
}
