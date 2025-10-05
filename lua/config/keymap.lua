vim.g.mapleader = " "
vim.g.maplocalleader = " "

--fzf
vim.api.nvim_set_keymap("n", "<leader>h", ":FzfLua oldfiles<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('v', '<leader>j', '<ESC>:FzfLua grep_visual<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>j', ':FzfLua grep_cword<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', ':FzfLua files<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>l", ":FzfLua lines<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>;', ':FzfLua live_grep<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>m", ":FzfLua resume<cr>", { silent = true, noremap = true })
vim.keymap.set({ "n" }, "<leader>\'",
function()
    require("fzf-lua").complete_file({
        cmd = "rg --files",
        winopts = { preview = { hidden = true } }
    })
end, { silent = true, desc = "Fuzzy complete file" })

--terminal
vim.api.nvim_set_keymap("n", "<leader>t",
[[:let @" = expand("%:p:h")<cr>:tabnew<cr>:terminal<cr>acd <c-\><c-n>pa<cr>clear<cr>]],
{ silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>T", [[:tabnew<cr>:terminal<cr>a]], { silent = true, noremap = true })
vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { silent = true, noremap = true })

--tabs
vim.api.nvim_set_keymap("n", "<leader>9", ":tabp<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>0", ":tabn<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>(", ":-tabmove<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>)", ":+tabmove<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>_", ":$tabmove<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>*", ":0tabmove<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>w", "<ESC>:tabc<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>n", "<ESC>:tabnew<cr>", { silent = true, noremap = true })

--misc
vim.api.nvim_set_keymap("n", "<leader>a", ":NvimTreeToggle<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>.", "<S-*>ggn", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>Q", ":qa<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>=", ":set number!<cr>:set relativenumber!<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>q", "@q", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<cr>', '<cr>', {})

--moves
vim.api.nvim_set_keymap('n', '<c-j>', "10j", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<c-k>', "10k", { silent = true, noremap = true })
vim.api.nvim_set_keymap('v', '<c-j>', "10j", { silent = true, noremap = true })
vim.api.nvim_set_keymap('v', '<c-k>', "10k", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<c-h>', "^", { silent = true, noremap = true })
vim.api.nvim_set_keymap('i', '<c-h>', "<esc>^i", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<c-l>', "$", { silent = true, noremap = true })
vim.api.nvim_set_keymap('i', '<c-l>', "<esc>$a", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', 'gH', [[<Cmd>wincmd h<CR>]], { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', 'gJ', [[<Cmd>wincmd j<CR>]], { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', 'gK', [[<Cmd>wincmd k<CR>]], { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', 'gL', [[<Cmd>wincmd l<CR>]], { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>+', "gg=G<c-o>", { silent = true, noremap = true })
