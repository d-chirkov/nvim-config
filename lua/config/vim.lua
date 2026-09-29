vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.winborder = "rounded"
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd([[
set clipboard+=unnamedplus
set termguicolors
nnoremap q: <nop>
set nocompatible            " disable compatibility to old-time vi
" set showmatch             " show matching
set ignorecase smartcase    
"set hlsearch               " highlight search
set nohlsearch
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
" set cc=120                " set an column border for good coding style
filetype plugin indent on   " allow auto-indenting depending on file type
syntax on                   " syntax highlighting
" set mouse=                  " disable mouse click
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
set noswapfile              " disable creating swap file
" set clipboard=
set fillchars=eob:\ ,fold:\ ,vert:\│ " remove unnecessary tildas at empty lines
let &scrolloff = 0
set smoothscroll
set showtabline=0
set relativenumber
au TextYankPost * silent! lua vim.highlight.on_yank()
autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no nocursorline
set t_Co=256
" au TermEnter * setlocal scrolloff=0
" au TermLeave * setlocal scrolloff=0
]])

vim.opt.guicursor = table.concat({
  "n-v-c-sm:block",   -- normal/visual: block
  "i-ci-ve:ver25",    -- insert: vertical bar
  "r-cr-o:hor20",     -- replace/operator: horizontal (optional)
  "t:ver25",          -- terminal insert: vertical bar
}, ",")

vim.diagnostic.config({ jump = { float = true } })

-- removes jdtls notifications which appears on each file opening
local orig_progress = vim.lsp.handlers["$/progress"]
vim.lsp.handlers["$/progress"] = function(err, result, ctx, config)
	local client = ctx and vim.lsp.get_client_by_id(ctx.client_id)
	if client and client.name == "jdtls" then
		local val = result and result.value
		if
			val
			and type(val.message) == "string"
			and (val.message:match("Validate documents") or val.message:match("Publish Diagnostics"))
		then
			return
		end
	end
	return orig_progress(err, result, ctx, config)
end

vim.o.ttimeout = true
vim.o.ttimeoutlen = 50
vim.opt.updatetime = 50
vim.o.autowriteall = true

local hidden_buffer_group = vim.api.nvim_create_augroup("delete_hidden_buffers", { clear = true })

local function is_in_jumplist(bufnr)
	for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
		local tabnr = vim.api.nvim_tabpage_get_number(tabpage)

		for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
			local winnr = vim.fn.win_id2tabwin(winid)[2]
			local jumplist = vim.fn.getjumplist(winnr, tabnr)[1]

			for _, jump in ipairs(jumplist) do
				if jump.bufnr == bufnr then
					return true
				end
			end
		end
	end

	return false
end

vim.api.nvim_create_autocmd("BufHidden", {
	group = hidden_buffer_group,
	desc = "Delete unmodified hidden file buffers that are not jump targets",
	callback = function(args)
		local bufnr = args.buf

		vim.schedule(function()
			if not vim.api.nvim_buf_is_valid(bufnr) or not vim.api.nvim_buf_is_loaded(bufnr) then
				return
			end

			if #vim.fn.win_findbuf(bufnr) > 0 then
				return
			end

			local buffer_options = vim.bo[bufnr]
			if
				buffer_options.buftype == ""
				and buffer_options.buflisted
				and not buffer_options.modified
				and not is_in_jumplist(bufnr)
			then
				vim.api.nvim_buf_delete(bufnr, {})
			end
		end)
	end,
})
