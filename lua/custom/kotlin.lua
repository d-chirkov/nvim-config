local M = {}

local function workspace_is_locked(workspace_dir)
	if vim.fn.executable("lsof") == 0 then
		return false
	end

	local pattern = "workspaces/*/index/kotlin-server/rocks/*/LOCK"
	for _, lock_file in ipairs(vim.fn.globpath(workspace_dir, pattern, false, true)) do
		local result = vim.system({ "lsof", "-t", lock_file }, { text = true }):wait()
		if result.code == 0 and vim.trim(result.stdout) ~= "" then
			return true
		end
	end

	return false
end

function M.isolate_concurrent_workspaces(kotlin)
	local default_workspace_dir_for_root = kotlin.workspace_dir_for_root
	local workspace_dirs = {}

	kotlin.workspace_dir_for_root = function(root)
		root = vim.fs.normalize(root)
		if workspace_dirs[root] then
			return workspace_dirs[root]
		end

		local workspace_dir = default_workspace_dir_for_root(root)
		local workspace_base = workspace_dir
		local slot = 2
		while workspace_is_locked(workspace_dir) do
			workspace_dir = workspace_base .. "-nvim-" .. slot
			slot = slot + 1
		end
		workspace_dirs[root] = workspace_dir
		return workspace_dir
	end
end

return M
