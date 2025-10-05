return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			icons_enabled = true,
            --theme = "16base",
			theme = "16color",
			--theme = 'moonfly',
			--theme = 'powerline',
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			--component_separators = { left = '<EE><82><B1>', right = '<EE><82><B3>'},
			--section_separators = { left = '<EE><82><B0>', right = '<EE><82><B2>'},
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
		},
		sections = {
			lualine_a = {
				{
					"tabs",
					mode = 2,
					max_length = 2 * vim.o.columns / 3,
					--use_mode_colors = true,
					fmt = function(name, context)
						local buflist = vim.fn.tabpagebuflist(context.tabnr)
						local winnr = vim.fn.tabpagewinnr(context.tabnr)
						local bufnr = buflist[winnr]
						local mod = vim.fn.getbufvar(bufnr, "&mod")

						return (mod == 1 and "*" or "") .. name
					end,
				},
			},
			lualine_b = {},
			lualine_c = { { "filename", path = 1 } },
			lualine_x = {},
			lualine_y = { "location", "progress", "selectioncount" },
			lualine_z = { "mode" },
		},
		extensions = {},
	},
}
