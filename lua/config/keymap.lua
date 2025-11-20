-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--misc
vim.keymap.set("n", "<cr>", "<cr>", { desc = "enter" })
local function close_floating()
	local inactive_floating_wins = vim.fn.filter(vim.api.nvim_list_wins(), function(k, v)
		local file_type = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(v), "filetype")

		return vim.api.nvim_win_get_config(v).relative ~= ""
			and v ~= vim.api.nvim_get_current_win()
			and file_type ~= "hydra_hint"
	end)
	for _, w in ipairs(inactive_floating_wins) do
		pcall(vim.api.nvim_win_close, w, false)
	end
end
vim.keymap.set("n", "<esc>", close_floating, { desc = "close float window" })
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { silent = true, noremap = true, desc = "term: esc" })

--tabs
vim.keymap.set("n", "<c-;>", "<ESC>:tabnew<cr>", { silent = true, noremap = true, desc = "tab: new" })
vim.keymap.set("n", "<c-t>", "<ESC>:tabnew<cr>", { silent = true, noremap = true, desc = "tab: new" })
vim.keymap.set("n", "<c-,>", ":tabp<cr>", { silent = true, noremap = true, desc = "tab: previous" })
vim.keymap.set("n", "<c-.>", ":tabn<cr>", { silent = true, noremap = true, desc = "tab: next" })
vim.keymap.set("n", "<c-8>", ":0tabmove<cr>", { silent = true, noremap = true, desc = "tab: move to the beginning" })
vim.keymap.set("n", "<c-9>", ":-tabmove<cr>", { silent = true, noremap = true, desc = "tab: move left" })
vim.keymap.set("n", "<c-0>", ":+tabmove<cr>", { silent = true, noremap = true, desc = "tab: move right" })
vim.keymap.set("n", "<c-->", ":$tabmove<cr>", { silent = true, noremap = true, desc = "tab: move to the end" })
vim.keymap.set("n", "<c-c>", "<ESC>:q<cr>", { silent = true, noremap = true, desc = "document: close" })
vim.keymap.set("n", "<c-q>", "<ESC>:q!<cr>", { silent = true, noremap = true, desc = "document: close without saving" })

--moves
vim.keymap.set("n", "<c-j>", "10j", { silent = true, noremap = true, desc = "goto: up 10 lines" })
vim.keymap.set("n", "<c-k>", "10k", { silent = true, noremap = true, desc = "goto down 10 lines" })
vim.keymap.set("v", "<c-j>", "10j", { silent = true, noremap = true, desc = "goto: up 10 lines" })
vim.keymap.set("v", "<c-k>", "10k", { silent = true, noremap = true, desc = "goto: down 10 lines" })
vim.keymap.set("n", "<c-h>", "^", { silent = true, noremap = true, desc = "goto: left" })
vim.keymap.set("i", "<c-h>", "<esc>^i", { silent = true, noremap = true, desc = "goto: left" })
vim.keymap.set("n", "<c-l>", "$", { silent = true, noremap = true, desc = "goto: right" })
vim.keymap.set("i", "<c-l>", "<esc>$a", { silent = true, noremap = true, desc = "goto: right" })
vim.keymap.set({ "n", "v" }, "]f", "]gfzz", { silent = true, remap = true, desc = "goto: next function" })
vim.keymap.set({ "n", "v" }, "[f", "[gfzz", { silent = true, remap = true, desc = "goto: prev function" })
vim.keymap.set({ "n", "v" }, "]s", "]gczz", { silent = true, remap = true, desc = "goto: next class" })
vim.keymap.set({ "n", "v" }, "[s", "[gczz", { silent = true, remap = true, desc = "goto: prev class" })
-- vim.keymap.set({ "n", "v" }, "]f", "]gfzt", { silent = true, remap = true, desc = "goto: next function" })
-- vim.keymap.set({ "n", "v" }, "[f", "[gfzt", { silent = true, remap = true, desc = "goto: prev function" })
-- vim.keymap.set({ "n", "v" }, "]s", "]gczt", { silent = true, remap = true, desc = "goto: next class" })
-- vim.keymap.set({ "n", "v" }, "[s", "[gczt", { silent = true, remap = true, desc = "goto: prev class" })
vim.keymap.set({ "n", "v" }, "[c", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true, remap = true, desc = "goto: prev context" })
vim.keymap.set({ "n", "v" }, "]e", function()
	vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end, { desc = "diagnostics: next error" })
vim.keymap.set("n", "[e", function()
	vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end, { desc = "diagnostics: prev error" })
local PROMPT = [[\v^\d{2}:\d{2}:\d{2}\>\s]]
vim.keymap.set({ "n", "v" }, "]t", function()
	vim.fn.search(PROMPT, "W")
	vim.cmd("normal! ztkj")
end, { desc = "term: next command" })
vim.keymap.set({ "n", "v" }, "[t", function()
	vim.fn.search(PROMPT, "bW")
	vim.cmd("normal! ztkj")
end, { desc = "term: prev command" })

-- basic layer
vim.keymap.set(
	"n",
	"<leader>=",
	":set number!<cr>:set relativenumber!<cr>",
	{ silent = true, noremap = true, desc = "toggle: line numbers" }
)
vim.keymap.set("n", "<leader>+", "gg=G<c-o>", { silent = true, noremap = true, desc = "format simple" })
vim.keymap.set("n", "<leader>q", "@q", { silent = true, noremap = true, desc = "run macro" })
vim.keymap.set("n", "<leader>Q", ":qa<cr>", { silent = true, noremap = true, desc = "quit" })
vim.keymap.set("n", "<leader>w", ":Markview<cr>", { silent = true, noremap = true, desc = "git: blame" })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { silent = true, noremap = true, desc = "lsp rename" })
vim.keymap.set(
	"n",
	"<leader>y",
	":FzfLua lsp_typedefs<cr>",
	{ silent = true, noremap = true, desc = "fzf: lsp type definisions" }
)
vim.keymap.set(
	"n",
	"<leader>u",
	":FzfLua lsp_references<cr>",
	{ silent = true, noremap = true, desc = "fsf: lsp references" }
)
vim.keymap.set(
	"n",
	"<leader>i",
	":FzfLua lsp_implementations<cr>",
	{ silent = true, noremap = true, desc = "fzf: lsp implementations" }
)
vim.keymap.set(
	"n",
	"<leader>o",
	vim.diagnostic.open_float,
	{ silent = true, noremap = true, desc = "diagnostics: float" }
)
vim.keymap.set("n", "<leader>p", ":FzfLua jumps<cr>", { noremap = true, silent = true, desc = "fzf: jumps" })
vim.keymap.set("n", "<leader>a", ":NvimTreeToggle<cr>", { silent = true, noremap = true, desc = "file tree" })
vim.keymap.set("n", "<leader>s", ":w<cr>", { silent = true, noremap = true, desc = "save document" })
vim.keymap.set("n", "<leader>S", ":wa<cr>", { silent = true, noremap = true, desc = "save all" })
vim.keymap.set(
	"n",
	"<leader>d",
	":FzfLua lsp_definitions<cr>",
	{ silent = true, noremap = true, desc = "fzf: lsp definitions" }
)
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ async = true }, function(err)
		if not err then
			local mode = vim.api.nvim_get_mode().mode
			if vim.startswith(string.lower(mode), "v") then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
			end
		end
	end)
end, { desc = "format" })
vim.keymap.set("n", "<leader>g", ":LazyGit<cr>", { silent = true, noremap = true, desc = "lazygit" })
vim.keymap.set("n", "<leader>h", function()
	require("fzf-lua").oldfiles({
		cwd = vim.loop.cwd(),
		include_current_session = true,
		filter = function(path)
			return path:find(vim.loop.cwd(), 1, true)
		end,
	})
end, { silent = true, noremap = true, desc = "fzf: old files" })
vim.keymap.set("n", "<leader>j", ":FzfLua live_grep<cr><c-g>", { noremap = true, silent = true, desc = "fzf: grep" })
vim.keymap.set("v", "<leader>j", ":FzfLua grep_visual<cr>", { noremap = true, silent = true, desc = "fzf: grep" })
vim.keymap.set(
	"n",
	"<leader>J",
	":FzfLua grep_cword<cr>",
	{ noremap = true, silent = true, desc = "fzf: grep word under cursor" }
)

vim.keymap.set("n", "<leader>k", function()
	require("fzf-lua").files({ cwd = vim.fn.getcwd(-1, -1) })
end, { noremap = true, silent = true, desc = "fzf: file" })

vim.keymap.set("x", "<leader>k", function()
	vim.cmd('normal! "vy')
	local text = vim.fn.getreg("v")
	if text and #text > 0 then
		require("fzf-lua").files({
			cwd = vim.fn.getcwd(-1, -1),
			fzf_opts = { ["--query"] = text },
		})
	end
end, { noremap = true, silent = true, desc = "fzf: file" })

vim.keymap.set("n", "<leader>K", function()
	local word = vim.fn.expand("<cword>")
	require("fzf-lua").files({
		cwd = vim.fn.getcwd(-1, -1),
		fzf_opts = { ["--query"] = word },
	})
end, { noremap = true, silent = true, desc = "fzf: file under cursor" })

vim.keymap.set(
	"n",
	"<leader>l",
	":FzfLua lsp_workspace_symbols<cr>",
	{ noremap = true, silent = true, desc = "fzf: lsp workspace symbols" }
)

vim.keymap.set("n", "<leader>L", function()
	local word = vim.fn.expand("<cword>")
	require("fzf-lua").lsp_workspace_symbols({ query = word })
end, { desc = "fzf: lsp workspace symbol under cursor" })

vim.keymap.set("v", "<leader>l", function()
	vim.cmd('noau normal! "vy')
	local text = vim.fn.getreg("v")
	if text ~= "" then
		require("fzf-lua").lsp_workspace_symbols({ query = text })
	end
end, { desc = "fzf: lsp workspace symbols" })

vim.keymap.set("n", "<leader>;", ":FzfLua resume<cr>", { silent = true, noremap = true, desc = "fzf: resume" })
vim.keymap.set(
	"n",
	"<leader>'",
	require("aerial").fzf_lua_picker,
	{ silent = true, noremap = true, desc = "fzf: structure" }
)
vim.keymap.set(
	"n",
	"<leader>c",
	":FzfLua lsp_code_actions<cr>",
	{ silent = true, noremap = true, desc = "fzf: lsp code actions" }
)
vim.keymap.set("n", "<leader>b", ":FzfLua live_grep<cr>", { noremap = true, silent = true, desc = "fzf: grep" })
vim.keymap.set(
	"n",
	"<leader>n",
	":FzfLua grep_curbuf<cr>",
	{ noremap = true, silent = true, desc = "fzf: grep current document" }
)
vim.keymap.set(
	"n",
	"<leader>m",
	":FzfLua lsp_document_symbols<cr>",
	{ noremap = true, silent = true, desc = "fzf: lsp document symbols" }
)
vim.keymap.set(
	"n",
	"<leader>,",
	":FzfLua lsp_workspace_diagnostics<cr>",
	{ noremap = true, silent = true, desc = "fzf: lsp document symbols" }
)
vim.keymap.set("n", "<leader>.", function()
	local dir

	if vim.bo.buftype == "terminal" then
		local name = vim.api.nvim_buf_get_name(0)
		dir = name:match(";cwd=(.-)//%d+:") or name:match("term://[^/]+//%d+:(.+)")
	else
		dir = vim.fn.expand("%:p:h")
	end

	if not dir or dir == "" or vim.fn.isdirectory(dir) == 0 then
		dir = vim.fn.getcwd()
	end

	vim.cmd("tabnew")
	vim.cmd("tcd " .. vim.fn.fnameescape(dir))
	vim.cmd("terminal")
	vim.cmd("startinsert")
end, { silent = true, noremap = true, desc = "term: document location" })
vim.keymap.set("n", "<leader>/", function()
	local root = vim.fn.getcwd(-1, -1)
	vim.cmd("tabnew")
	vim.cmd("tcd " .. vim.fn.fnameescape(root))
	vim.cmd("terminal")
	vim.cmd("startinsert")
end, { silent = true, noremap = true, desc = "term: root location" })

-- exteneded layer
vim.keymap.set("n", "<leader>eq", ":FzfLua quickfix<cr>", { silent = true, noremap = true, desc = "fzf: quickfix" })
vim.keymap.set(
	"n",
	"<leader>er",
	":Gitsigns reset_hunk<cr>",
	{ silent = true, noremap = true, desc = "git: reset hunk" }
)
vim.keymap.set("n", "<leader>eu", function()
	require("custom.git_url").open_in_git_web(vim.fn.line("."))
end, { desc = "git: open url" })
vim.keymap.set("v", "<leader>eu", function()
	local s = vim.fn.getpos("'<")[2]
	local e = vim.fn.getpos("'>")[2]
	if s > e then
		s, e = e, s
	end
	require("custom.git_url").open_in_git_web(s, e)
	vim.schedule(function()
		vim.cmd("normal! gv")
	end)
end, { desc = "git: open url" })
vim.keymap.set("n", "<leader>ei", ":Import", { silent = true, noremap = true, desc = "import" })
vim.keymap.set(
	"n",
	"<leader>ep",
	":Gitsigns preview_hunk<cr>",
	{ silent = true, noremap = true, desc = "git: preview hunk" }
)
vim.keymap.set(
	"n",
	"<leader>ed",
	":FzfLua diagnostics_document<cr>",
	{ silent = true, noremap = true, desc = "fzf: diagnostics document" }
)
vim.keymap.set("n", "<leader>ef", ":FzfLua<cr>", { silent = true, noremap = true, desc = "fzf" })
vim.keymap.set("n", "<leader>eg", ":FzfLua<cr>^git_", { silent = true, noremap = true, desc = "fzf: git" })
vim.keymap.set(
	"n",
	"<leader>eh",
	":FzfLua git_bcommits<cr>",
	{ silent = true, noremap = true, desc = "git: history: document" }
)
vim.keymap.set("n", "<leader>ek", ":FzfLua keymaps<cr>", { silent = true, noremap = true, desc = "fzf: keymaps" })
vim.keymap.set("n", "<leader>el", ":FzfLua<cr>^lsp_", { silent = true, noremap = true, desc = "fzf: lsp" })
vim.keymap.set("n", "<leader>eb", ":Gitsigns blame<cr>", { silent = true, noremap = true, desc = "git: blame" })
vim.keymap.set("n", "<leader>em", ":Markview<cr>", { silent = true, noremap = true, desc = "git: blame" })

-- toggles
vim.keymap.set("n", "<leader>eth", function()
	local b = vim.api.nvim_get_current_buf()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = b }), { bufnr = b })
end, { desc = "toggle: inlay hints" })
