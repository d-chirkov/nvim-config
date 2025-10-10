--format
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("", "<leader>f", function()
	require("conform").format({ async = true }, function(err)
		if not err then
			local mode = vim.api.nvim_get_mode().mode
			if vim.startswith(string.lower(mode), "v") then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
			end
		end
	end)
end, { desc = "Format code" })

--lsp
vim.keymap.set("n", "<leader>d", ":FzfLua lsp_definitions<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>u", ":FzfLua lsp_references<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>i", ":FzfLua lsp_implementations<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>s", ":FzfLua lsp_code_actions<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>y", ":FzfLua lsp_typedefs<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>p", ":FzfLua diagnostics_document<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>o", vim.diagnostic.open_float, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>O", vim.lsp.buf.document_highlight, { silent = true, noremap = true })

vim.keymap.set("n", "]e", function()
	vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next error" })

vim.keymap.set("n", "[e", function()
	vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Prev error" })

vim.keymap.set("n", "<leader>cd", function()
    require("tiny-inline-diagnostic").toggle()
end, { desc = "Prev error" })



--fzf
vim.keymap.set("n", "<leader>h", ":FzfLua oldfiles<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>k", function()
	require("fzf-lua").files({ cwd = vim.fn.getcwd(-1, -1) })
end, { noremap = true, silent = true })
vim.keymap.set("x", "<leader>k", function()
	vim.cmd('normal! "vy')
	local text = vim.fn.getreg("v")
	if text and #text > 0 then
		require("fzf-lua").files({
			cwd = vim.fn.getcwd(-1, -1),
			fzf_opts = { ["--query"] = text },
		})
	end
end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>K", function()
	local word = vim.fn.expand("<cword>")
	require("fzf-lua").files({
		cwd = vim.fn.getcwd(-1, -1),
		fzf_opts = { ["--query"] = word },
	})
end, { desc = "Workspace symbols for word under cursor" })
vim.keymap.set("n", "<leader>l", ":FzfLua grep_curbuf<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>g", ":FzfLua git_hunks<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>j", ":FzfLua live_grep<cr><c-g>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>j", ":FzfLua grep_visual<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>;", ":FzfLua resume<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>J", function()
	local word = vim.fn.expand("<cword>")
	require("fzf-lua").lsp_workspace_symbols({ query = word })
end, { desc = "Workspace symbols for word under cursor" })
vim.keymap.set("v", "<leader>J", function()
	vim.cmd('noau normal! "vy')
	local text = vim.fn.getreg("v")
	if text ~= "" then
		require("fzf-lua").lsp_workspace_symbols({ query = text })
	end
end, { desc = "Workspace symbols for selected text" })

--extra mappings
vim.keymap.set("n", "<leader>ci", ":FzfLua lsp_incoming_calls<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>co", ":FzfLua lsp_outgoing_calls<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>cm", ":Markview Toggle<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>ch", function()
	local b = vim.api.nvim_get_current_buf()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = b }), { bufnr = b })
end, { desc = "Toggle Inlay Hints" })
vim.keymap.set("n", "<leader>cb", ":Gitsigns blame<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>cl", ":Gitsigns blame_line<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>cr", ":Gitsigns reset_hunk<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>cp", ":Gitsigns preview_hunk<cr>", { silent = true, noremap = true })

--terminal
vim.keymap.set("n", "<leader>T", function()
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
end, { silent = true, noremap = true })

vim.keymap.set("n", "<leader>t", function()
	local root = vim.fn.getcwd(-1, -1)
	vim.cmd("tabnew")
	vim.cmd("tcd " .. vim.fn.fnameescape(root))
	vim.cmd("terminal")
	vim.cmd("startinsert")
end, { silent = true, noremap = true })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { silent = true, noremap = true })

--tabs
--vim.keymap.set("n", "<leader>9", ":tabp<cr>", { silent = true, noremap = true })
--vim.keymap.set("n", "<leader>0", ":tabn<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>(", ":-tabmove<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>)", ":+tabmove<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>_", ":$tabmove<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>*", ":0tabmove<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>w", "<ESC>:tabc<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>n", "<ESC>:tabnew<cr>", { silent = true, noremap = true })

vim.keymap.set("n", "<c-[>", ":tabp<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<c-]>", ":tabn<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<c-9>", ":-tabmove<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<c-0>", ":+tabmove<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<c-8>", ":0tabmove<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<c-->", ":$tabmove<cr>", { silent = true, noremap = true })
--vim.keymap.set("n", "<c-c>", "<ESC>:tabc<cr>", { silent = true, noremap = true })
--vim.keymap.set("i", "<c-c>", "<ESC>:tabc<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<c-c>", "<ESC>:q<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<c-v>", "<ESC>:q!<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<c-n>", "<ESC>:tabnew<cr>", { silent = true, noremap = true })
vim.keymap.set("i", "<c-n>", "<ESC>:tabnew<cr>", { silent = true, noremap = true })

--misc
vim.keymap.set("n", "<leader>a", ":NvimTreeToggle<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>.", "<S-*>ggn", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>Q", ":qa<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>=", ":set number!<cr>:set relativenumber!<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>q", "@q", { silent = true, noremap = true })
vim.keymap.set("n", "<cr>", "<cr>", {})

--moves
vim.keymap.set("n", "<c-j>", "10j", { silent = true, noremap = true })
vim.keymap.set("n", "<c-k>", "10k", { silent = true, noremap = true })
vim.keymap.set("v", "<c-j>", "10j", { silent = true, noremap = true })
vim.keymap.set("v", "<c-k>", "10k", { silent = true, noremap = true })
vim.keymap.set("n", "<c-h>", "^", { silent = true, noremap = true })
vim.keymap.set("i", "<c-h>", "<esc>^i", { silent = true, noremap = true })
vim.keymap.set("n", "<c-l>", "$", { silent = true, noremap = true })
vim.keymap.set("i", "<c-l>", "<esc>$a", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>+", "gg=G<c-o>", { silent = true, noremap = true })
vim.keymap.set("n", "]f", "]gfzt", { silent = true, remap = true })
vim.keymap.set("n", "[f", "[gfzt", { silent = true, remap = true })
vim.keymap.set("n", "]F", "]gFzb", { silent = true, remap = true })
vim.keymap.set("n", "[F", "[gFzb", { silent = true, remap = true })
vim.keymap.set("n", "]c", "]gczt", { silent = true, remap = true })
vim.keymap.set("n", "[c", "[gczt", { silent = true, remap = true })
vim.keymap.set("n", "]C", "]gCzb", { silent = true, remap = true })
vim.keymap.set("n", "[C", "[gCzb", { silent = true, remap = true })
