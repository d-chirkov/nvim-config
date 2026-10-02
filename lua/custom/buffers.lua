local M = {}

function M.close_hidden()
	local visible = {}
	for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
		for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
			visible[vim.api.nvim_win_get_buf(winid)] = true
		end
	end

	local skipped = 0
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buflisted and not visible[bufnr] then
			if vim.bo[bufnr].modified then
				skipped = skipped + 1
			else
				local ok = pcall(vim.api.nvim_buf_delete, bufnr, {})
				if not ok then
					skipped = skipped + 1
				end
			end
		end
	end

	if skipped > 0 then
		vim.notify(("Could not close %d hidden buffer(s)"):format(skipped), vim.log.levels.WARN)
	end
end

return M
