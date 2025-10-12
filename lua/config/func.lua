local M = {}

function M.open_in_git_web(start_line, end_line)
	local file = vim.fn.expand("%:p")
	local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	if not git_root or git_root == "" then
		return
	end
	local rel_path = file:sub(#git_root + 2)

	local remote = (vim.fn.systemlist("git remote get-url origin")[1] or ""):gsub("%s+$", "")
	local branch = (vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1] or ""):gsub("%s+$", "")

	local function url_encode_path(p)
		return (p:gsub("([^%w%-%._~/])", function(c)
			return string.format("%%%02X", string.byte(c))
		end))
	end

	local function normalize_remote(u)
		u = u:gsub("%s+$", ""):gsub("%.git$", "")

		if u:match("^https?://") then
			return u
		end

		-- ssh://user@host[:port]/path -> https://host/path
		if u:match("^ssh://") then
			local hp = u:gsub("^ssh://", "") -- drop scheme
			hp = hp:gsub("^[^@]+@", "") -- drop user@
			hp = hp:gsub("^([^/:%s]+):%d+/", "%1/") -- drop :port/ if any
			return "https://" .. hp
		end

		-- scp-like user@host:path -> https://host/path
		local _, host, path = u:match("^([^@]+)@([^:]+):(.+)$")
		if host and path then
			return ("https://%s/%s"):format(host, path)
		end

		-- git://host/path -> https://host/path
		local after = u:match("^git://(.+)$")
		if after then
			return "https://" .. after
		end

		if u:match("^[%w%.-]+/.+") then
			return "https://" .. u
		end
		return u
	end

	local base = normalize_remote(remote)
	local enc_branch = url_encode_path(branch)
	local enc_path = url_encode_path(rel_path)

	-- anchor builders per host (single line or range)
	local anchor
	if base:match("gitlab") then
		-- GitLab: #L<start> or #L<start>-<end>
		anchor = (start_line and end_line and start_line ~= end_line) and string.format("#L%d-%d", start_line, end_line)
			or string.format("#L%d", start_line or 1)
		url = string.format("%s/-/blob/%s/%s%s", base, enc_branch, enc_path, anchor)
	elseif base:match("github") then
		-- GitHub: #L<start> or #L<start>-L<end>
		anchor = (start_line and end_line and start_line ~= end_line)
				and string.format("#L%d-L%d", start_line, end_line)
			or string.format("#L%d", start_line or 1)
		url = string.format("%s/blob/%s/%s%s", base, enc_branch, enc_path, anchor)
	elseif base:match("bitbucket") then
		-- Bitbucket: #lines-<start> or #lines-<start>:<end>
		anchor = (start_line and end_line and start_line ~= end_line)
				and string.format("#lines-%d:%d", start_line, end_line)
			or string.format("#lines-%d", start_line or 1)
		url = string.format("%s/src/%s/%s%s", base, enc_branch, enc_path, anchor)
	elseif base:match("gitea") then
		-- Gitea follows GitHub-style anchors
		anchor = (start_line and end_line and start_line ~= end_line)
				and string.format("#L%d-L%d", start_line, end_line)
			or string.format("#L%d", start_line or 1)
		url = string.format("%s/src/branch/%s/%s%s", base, enc_branch, enc_path, anchor)
	else
		-- Sensible default (GitHub-style)
		anchor = (start_line and end_line and start_line ~= end_line)
				and string.format("#L%d-L%d", start_line, end_line)
			or string.format("#L%d", start_line or 1)
		url = string.format("%s/blob/%s/%s%s", base, enc_branch, enc_path, anchor)
	end

	local opener = (vim.fn.has("mac") == 1 and "open") or (vim.fn.has("unix") == 1 and "xdg-open") or "start"
	vim.fn.jobstart({ opener, url }, { detach = true })
end

return M
