local M = {}

local searches = {}
local current = 0
local max_searches = 50

local function identity(search)
	local opts = search.opts
	local picker = opts.__INFO and opts.__INFO.cmd or tostring(opts.__resume_key)
	local source = opts.__history_key
	if not source then
		local context = opts.__CTX or {}
		local buffer_local = picker:find("curbuf", 1, true) or picker:find("blines", 1, true)
		local lsp = picker:find("lsp_", 1, true) == 1
		source = {
			picker = picker,
			cwd = opts.cwd,
			prompt = opts.prompt,
			buf = opts.bufnr or opts.buf or (buffer_local or lsp) and context.bname,
			cursor = lsp and context.cursor or nil,
			search = opts.search,
			hidden = opts.hidden,
			no_ignore = opts.no_ignore,
		}
	end
	return { source = source, query = opts.last_query or opts.query or "" }
end

local function deduplicate()
	local selected = searches[current]
	local seen = {}
	for i = #searches, 1, -1 do
		local search = searches[i]
		local key = identity(search)
		local duplicate
		for _, newer in ipairs(seen) do
			if vim.deep_equal(key, newer.key) then
				duplicate = newer.search
				break
			end
		end
		if duplicate then
			if selected == search then
				selected = duplicate
			end
			table.remove(searches, i)
		else
			table.insert(seen, { key = key, search = search })
		end
	end
	for i, search in ipairs(searches) do
		if search == selected then
			current = i
			return
		end
	end
	current = 0
end

function M.enrich(opts)
	if not opts.no_resume then
		opts.actions = opts.actions or {}
		for key, action in pairs({ left = M.previous, right = M.next }) do
			if opts.actions[key] and not opts.actions["alt-" .. key] then
				opts.actions["alt-" .. key] = opts.actions[key]
			end
			opts.actions[key] = { fn = action, reuse = true }
		end
	end
	return require("fzf-lua.profiles.hide").defaults.enrich(opts)
end

function M.record()
	local data = require("fzf-lua.config").__resume_data
	if not data or not data.opts or not data.contents or data.opts.no_resume then
		return
	end
	deduplicate()

	for i, search in ipairs(searches) do
		if search.opts == data.opts then
			current = i
			return
		end
	end

	for i = #searches, current + 1, -1 do
		searches[i] = nil
	end

	searches[#searches + 1] = { opts = data.opts, contents = data.contents }
	if #searches > max_searches then
		table.remove(searches, 1)
	end
	current = #searches
end

local function activate(search)
	require("fzf-lua.config").__resume_data = {
		opts = search.opts,
		contents = search.contents,
		last_query = search.opts.last_query,
	}
end

local function navigate(step)
	deduplicate()
	local search = searches[current + step]
	if search then
		current = current + step
	end
	search = search or searches[current]
	if search then
		activate(search)
	end
	require("fzf-lua").resume()
end

function M.previous()
	navigate(-1)
end

function M.next()
	navigate(1)
end

function M.resume()
	deduplicate()
	local search = searches[current]
	if search then
		activate(search)
	end
	require("fzf-lua").resume()
end

return M
