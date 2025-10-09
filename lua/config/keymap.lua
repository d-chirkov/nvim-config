vim.g.mapleader = " "
vim.g.maplocalleader = " "

--format
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
vim.keymap.set("n", "<leader>ci", ":FzfLua lsp_incoming_calls<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>co", ":FzfLua lsp_outgoing_calls<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>y", ":FzfLua lsp_typedefs<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>p", ":FzfLua diagnostics_document<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>o", vim.diagnostic.open_float, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>O", vim.lsp.buf.document_highlight, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>e", function()
	vim.diagnostic.goto_next()
	vim.diagnostic.open_float(nil, { focus = false })
end, { desc = "Next diagnostic with float" })
vim.keymap.set("n", "<leader>E", function()
	vim.diagnostic.goto_prev()
	vim.diagnostic.open_float(nil, { focus = false })
end, { desc = "Previous diagnostic with float" })

--fzf
vim.keymap.set("n", "<leader>h", ":FzfLua oldfiles<cr>", { silent = true, noremap = true })
-- vim.keymap.set("v", "<leader>j", "<ESC>:FzfLua grep_visual<cr>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<leader>j", ":FzfLua grep_cword<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>k", ":FzfLua files<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>l", ":FzfLua lines<cr>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>;", ":FzfLua live_grep<cr><c-g>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>'", ":FzfLua lsp_document_symbols<cr>", { noremap = true, silent = true })
vim.keymap.set("n", '<leader>"', ":FzfLua lsp_workspace_symbols<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>r", ":FzfLua resume<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>g", ":FzfLua git_hunks<cr>", { silent = true, noremap = true })

vim.keymap.set("n", "<leader>j", ":FzfLua live_grep<cr><c-g>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>j", "<ESC>:FzfLua grep_visual<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>J", ":FzfLua grep_cword<cr>", { noremap = true, silent = true })

--markview
vim.keymap.set("n", "<leader>m", ":Markview Toggle<cr>", { silent = true, noremap = true })

--terminal
vim.keymap.set("n", "<leader>T", function()
  local dir

  if vim.bo.buftype == "terminal" then
    local name = vim.api.nvim_buf_get_name(0)
    dir = name:match(";cwd=(.-)//%d+:")
       or name:match("term://[^/]+//%d+:(.+)")
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
vim.keymap.set("n", "<leader>9", ":tabp<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>0", ":tabn<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>(", ":-tabmove<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>)", ":+tabmove<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>_", ":$tabmove<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>*", ":0tabmove<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>w", "<ESC>:tabc<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>n", "<ESC>:tabnew<cr>", { silent = true, noremap = true })

vim.keymap.set("n", "<c-9>", ":tabp<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<c-0>", ":tabn<cr>", { silent = true, noremap = true })
vim.keymap.set("i", "<c-9>", "<esc>:tabp<cr>", { silent = true, noremap = true })
vim.keymap.set("i", "<c-0>", "<esc>:tabn<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<c-(>", ":-tabmove<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<c-)>", ":+tabmove<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<c-_>", ":$tabmove<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<c-*>", ":0tabmove<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<c-->", "<ESC>:tabc<cr>", { silent = true, noremap = true })
vim.keymap.set("i", "<c-->", "<ESC>:tabc<cr>", { silent = true, noremap = true })
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
vim.keymap.set("n", "gH", [[<Cmd>wincmd h<CR>]], { silent = true, noremap = true })
vim.keymap.set("n", "gJ", [[<Cmd>wincmd j<CR>]], { silent = true, noremap = true })
vim.keymap.set("n", "gK", [[<Cmd>wincmd k<CR>]], { silent = true, noremap = true })
vim.keymap.set("n", "gL", [[<Cmd>wincmd l<CR>]], { silent = true, noremap = true })
vim.keymap.set("n", "<leader>+", "gg=G<c-o>", { silent = true, noremap = true })
