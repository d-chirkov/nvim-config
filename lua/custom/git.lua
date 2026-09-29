local M = {}

local function git_result(root, args)
	return vim.system(vim.list_extend({ "git" }, args), { cwd = root, text = true }):wait()
end

local function git_root()
	local result = git_result(nil, { "rev-parse", "--show-toplevel" })
	if result.code ~= 0 then
		vim.notify("Not inside a Git repository", vim.log.levels.WARN)
		return
	end
	return vim.trim(result.stdout)
end

local function git_files(root, args)
	local result = git_result(root, args)
	if result.code ~= 0 then
		local message = vim.trim(result.stderr)
		vim.notify(message ~= "" and message or "Git command failed", vim.log.levels.ERROR)
		return
	end
	return vim.split(vim.trim(result.stdout), "\n", { trimempty = true })
end

local function default_branch(root)
	local result = git_result(root, { "symbolic-ref", "--quiet", "--short", "refs/remotes/origin/HEAD" })
	local base = result.code == 0 and vim.trim(result.stdout) or nil
	if base and base ~= "" then
		return base
	end

	for _, branch in ipairs({ "main", "master", "develop" }) do
		for _, ref in ipairs({ "refs/remotes/origin/" .. branch, "refs/heads/" .. branch }) do
			result = git_result(root, { "rev-parse", "--verify", "--quiet", ref .. "^{commit}" })
			if result.code == 0 then
				return ref:gsub("^refs/remotes/", ""):gsub("^refs/heads/", "")
			end
		end
	end

	vim.notify("Could not find a default branch (main, master, or develop)", vim.log.levels.WARN)
end

local function local_files(root)
	local tracked = git_files(root, { "diff", "--name-only", "--diff-filter=d", "HEAD" })
	if not tracked then
		return
	end
	local untracked = git_files(root, { "ls-files", "--others", "--exclude-standard" })
	if not untracked then
		return
	end
	vim.list_extend(tracked, untracked)
	return tracked
end

local function add_unique(files, seen, additions)
	for _, file in ipairs(additions) do
		if not seen[file] then
			seen[file] = true
			table.insert(files, file)
		end
	end
end

local function diff_preview(ref)
	return "git ls-files --error-unmatch -- {} >/dev/null 2>&1 && git diff "
		.. vim.fn.shellescape(ref)
		.. " -- {} || git diff --no-index -- /dev/null {}"
end

local function show_files(root, files, opts)
	if #files == 0 then
		vim.notify(opts.empty_message, vim.log.levels.INFO)
		return
	end

	table.sort(files)
	local current_file = vim.fs.relpath(root, vim.api.nvim_buf_get_name(0))
	local current_file_index
	for index, file in ipairs(files) do
		if file == current_file then
			current_file_index = index
			break
		end
	end

	local fzf = require("fzf-lua")
	local fzf_opts = {
		cwd = root,
		prompt = opts.prompt,
		previewer = "builtin",
		preview = opts.preview,
		__history_key = { root, opts.prompt, opts.preview, vim.deepcopy(files) },
		actions = fzf.defaults.actions.files,
	}
	if current_file_index then
		fzf_opts.keymap = { fzf = { load = "pos(" .. current_file_index .. ")" } }
	end
	fzf.fzf_exec(files, fzf_opts)
end

function M.changed_files_from_default_branch()
	local root = git_root()
	if not root then
		return
	end
	local base = default_branch(root)
	if not base then
		return
	end

	local branch_files = git_files(root, { "diff", "--name-only", "--diff-filter=d", base .. "...HEAD" })
	local changed_local_files = local_files(root)
	if not branch_files or not changed_local_files then
		return
	end

	local files = {}
	local seen = {}
	add_unique(files, seen, branch_files)
	add_unique(files, seen, changed_local_files)

	local merge_base_result = git_result(root, { "merge-base", base, "HEAD" })
	local preview_ref = merge_base_result.code == 0 and vim.trim(merge_base_result.stdout) or base
	show_files(root, files, {
		prompt = "Changes vs " .. base .. "> ",
		preview = diff_preview(preview_ref),
		empty_message = "No files changed against " .. base,
	})
end

function M.local_changed_files()
	local root = git_root()
	if not root then
		return
	end
	local files = local_files(root)
	if not files then
		return
	end
	show_files(root, files, {
		prompt = "Local changes> ",
		preview = diff_preview("HEAD"),
		empty_message = "No local changes",
	})
end

return M
