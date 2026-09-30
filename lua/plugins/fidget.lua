local references_group = "lsp-references"
local pending_references = {}

return {
	"j-hui/fidget.nvim",
	event = "VeryLazy",
	opts = {
		notification = {
			window = { zindex = 60 }, -- Keep the indicator visible above the fzf-lua window.
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("LspRequest", {
			group = vim.api.nvim_create_augroup("LspReferencesStatus", { clear = true }),
			callback = function(event)
				local request = event.data.request
				if request.method ~= "textDocument/references" then
					return
				end

				local id = event.data.client_id .. ":" .. event.data.request_id
				if request.type == "pending" then
					if not next(pending_references) then
						require("fidget.notification").notify("Finding references", nil, {
							group = references_group,
							key = "search",
							ttl = math.huge,
							skip_history = true,
						})
					end
					pending_references[id] = true
				elseif pending_references[id] then
					pending_references[id] = nil
					vim.schedule(function()
						if not next(pending_references) then
							require("fidget.notification").clear(references_group)
						end
					end)
				end
			end,
		})
	end,
	config = function(_, opts)
		local fidget = require("fidget")
		fidget.setup(opts)
		fidget.notification.set_config(references_group, {
			name = "LSP",
			icon = fidget.spinner.animate("dots", 1),
		})
	end,
}
