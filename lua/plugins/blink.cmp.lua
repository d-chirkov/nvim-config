return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
    event = "VeryLazy",
	version = "1.*",
	opts = {
		keymap = {
            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-e>'] = { 'hide', 'fallback' },
			["<CR>"] = {
				function(cmp)
					if cmp.snippet_active() then
						return cmp.accept()
					else
						return cmp.select_and_accept()
					end
				end,
				"snippet_forward",
				"fallback",
			},
			["<S-Tab>"] = { "snippet_backward", "fallback" },

			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback_to_mappings" },
			["<C-n>"] = { "select_next", "fallback_to_mappings" },

			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },

			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 0,
			},
			menu = {
				auto_show = false,
			},
            accept = {
                auto_brackets = {
                    enabled = true,
                    blocked_filetypes = { 'kotlin' },
                },
            },
			--ghost_text = { enabled = true },
		},
		signature = {
			enabled = true,
			trigger = {
				enabled = false,
				show_on_trigger_character = false,
				show_on_insert_on_trigger_character = false,
			},
		},
		sources = {
			default = { "lsp", "path" },
		},
		fuzzy = {
			implementation = "prefer_rust_with_warning",
		},
		cmdline = {
			enabled = false,
		},
	},
	opts_extend = { "sources.default" },
}
