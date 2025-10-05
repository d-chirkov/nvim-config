local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"

vim.cmd([[
set termguicolors
nnoremap q: <nop>
set nocompatible            " disable compatibility to old-time vi
" set showmatch             " show matching
set ignorecase              " case insensitive
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
set mouse=                  " disable mouse click
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
set noswapfile              " disable creating swap file
set clipboard=
set fillchars=eob:\ ,fold:\ ,vert:\│ " remove unnecessary tildas at empty lines
let &scrolloff = 5
set showtabline=0
set relativenumber
au TextYankPost * silent! lua vim.highlight.on_yank()
autocmd TermOpen * setlocal nonumber norelativenumber
set t_Co=256
]])

--bindings

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


require("lazy").setup({
    spec = {

        {
            "nvim-tree/nvim-tree.lua",
            version = "*",
            lazy = false,
            dependencies = {
                "nvim-tree/nvim-web-devicons",
            },
            config = function()
                local function on_attach(bufnr)
                    local api = require('nvim-tree.api')
                    local function opts(desc)
                        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                    end
                    -- cusom nvim tree commands
                    vim.keymap.set("n", "gp", function()
                        local node = api.tree.get_node_under_cursor()
                        local path = vim.fn.fnamemodify(node.absolute_path, ":p:h")
                        vim.cmd('let @" = "' .. path .. '"')
                        local command = vim.api.nvim_replace_termcodes(
                            [[:tabnew<cr>:terminal<cr>acd <c-\><c-n>pa<cr>clear<cr>]], true, true, true)
                            vim.api.nvim_feedkeys(command, 'in', true)
                        end, opts("Run terminal in new tab"))
                        -- BEGIN_DEFAULT_ON_ATTACH
                        vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
                        vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
                        -- vim.keymap.set('n', '<C-k>', api.node.show_info_popup,              opts('Info'))
                        vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
                        vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
                        vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
                        vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
                        vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
                        vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
                        vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
                        vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
                        vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
                        vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
                        vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
                        vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
                        vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
                        vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
                        vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
                        vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
                        vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
                        vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
                        vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
                        vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
                        vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
                        vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
                        vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
                        vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
                        vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
                        vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
                        vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
                        vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
                        vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
                        vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
                        vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
                        vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
                        vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
                        vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
                        vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
                        vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
                        vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
                        vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
                        vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
                        vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
                        vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
                        vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
                        vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
                        vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
                        vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
                        vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
                        vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
                        vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
                        vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
                        -- END_DEFAULT_ON_ATTACH
                        vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
                        vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
                        vim.keymap.set('n', '<Esc>', api.tree.close, opts('Close'))
                        vim.keymap.set('n', 'ge', api.node.open.toggle_group_empty, opts('Toggle group empty'))
                    end
                    local HEIGHT_RATIO = 0.8
                    local WIDTH_RATIO = 0.5
                    require("nvim-tree").setup {
                        sort_by = "case_sensitive",
                        sync_root_with_cwd = true,
                        respect_buf_cwd = true,
                        on_attach = on_attach,
                        view = {
                            centralize_selection = true,
                            float = {
                                enable = true,
                                open_win_config = function()
                                    local screen_w = vim.opt.columns:get()
                                    local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                                    local window_w = screen_w * WIDTH_RATIO
                                    local window_h = screen_h * HEIGHT_RATIO
                                    local window_w_int = math.floor(window_w)
                                    local window_h_int = math.floor(window_h)
                                    local center_x = (screen_w - window_w) / 2
                                    local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
                                    return {
                                        border = 'rounded',
                                        relative = 'editor',
                                        row = center_y,
                                        col = center_x,
                                        width = window_w_int,
                                        height = window_h_int,
                                    }
                                end,
                            },
                            width = function()
                                return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
                            end,
                        },
                        tab = {
                            sync = {
                                open = true,
                                close = true,
                            },
                        },
                        renderer = {
                            group_empty = true,
                        },
                        update_focused_file = {
                            enable = true,
                            update_cwd = false,
                        }
                    }
                end,
            },

            {
                "Mofiqul/vscode.nvim",
                opts = {
                    transparent = true,
                    italic_comments = true,
                    --disable_nvimtree_bg = true,
                    color_overrides = {
                        vscLineNumber = '#b8b8b8',
                    },
                    group_overrides = {
                        --CursorLine = { bg='#dcdcdc' },
                        --MatchParen = { bg='#c0c0c0'},
                    }
                },
                config = function()
                    vim.cmd.colorscheme "vscode"
                end
            },

            {
                "nvim-treesitter/nvim-treesitter",
                dependencies = {
                    "nvim-treesitter/nvim-treesitter-textobjects",
                },
                build = ":TSUpdate",
                config = function()
                    local configs = require("nvim-treesitter.configs")
                    configs.setup({
                        ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'cmake', 'kotlin', 'java', 'bash', 'dockerfile', 'markdown', 'make', 'kotlin' },
                        highlight = {
                            enable = true,
                            additional_vim_regex_highlighting = false,
                        },
                        textobjects = {
                            select = {
                                enable = true,
                                lookahead = true,
                                keymaps = {
                                    ["af"] = "@function.outer",
                                    ["if"] = "@function.inner",
                                    ["ac"] = "@class.outer",
                                    ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                                    ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                                },
                                selection_modes = {
                                    ['@parameter.outer'] = 'v', -- charwise
                                    ['@function.outer'] = 'V',  -- linewise
                                    ['@class.outer'] = '<c-v>', -- blockwise
                                },
                                include_surrounding_whitespace = true,
                            },
                            move = {
                                enable = true,
                                set_jumps = true,
                                goto_next_start = {
                                    ["]f"] = "@function.outer",
                                    ["]c"] = "@class.outer",
                                    ["]]"] = "@function.outer",
                                },
                                goto_previous_start = {
                                    ["[f"] = "@function.outer",
                                    ["[c"] = "@class.outer",
                                    ["[["] = "@function.outer",
                                },
                            },
                        },
                    })
                end
            },

            {
                "kylechui/nvim-surround",
                version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
                event = "VeryLazy",
                config = function()
                    require("nvim-surround").setup({})
                end
            },

            {
                'chomosuke/term-edit.nvim',
                event = 'TermOpen',
                version = '1.*',
                opts = {
                    prompt_end = ':',
                }
            },

            {
                'nvim-lualine/lualine.nvim',
                dependencies = { 'nvim-tree/nvim-web-devicons' },
                opts = {
                    options = {
                        icons_enabled = true,
                        theme = '16color',
                        --theme = 'moonfly',
                        --theme = 'powerline',
                        component_separators = { left = '', right = '' },
                        section_separators = { left = '', right = '' },
                        --component_separators = { left = '<EE><82><B1>', right = '<EE><82><B3>'},
                        --section_separators = { left = '<EE><82><B0>', right = '<EE><82><B2>'},
                        disabled_filetypes = {
                            statusline = {},
                            winbar = {},
                        },
                        ignore_focus = {},
                        always_divide_middle = true,
                        globalstatus = false,
                        refresh = {
                            statusline = 1000,
                            tabline = 1000,
                            winbar = 1000,
                        }
                    },
                    sections = {
                        lualine_a = { {
                            'tabs',
                            mode = 2,
                            max_length = 2 * vim.o.columns / 3,
                            --use_mode_colors = true,
                            fmt = function(name, context)
                                local buflist = vim.fn.tabpagebuflist(context.tabnr)
                                local winnr = vim.fn.tabpagewinnr(context.tabnr)
                                local bufnr = buflist[winnr]
                                local mod = vim.fn.getbufvar(bufnr, '&mod')

                                return (mod == 1 and '*' or '') .. name
                            end
                        } },
                        lualine_b = {},
                        lualine_c = { { 'filename', path = 1 } },
                        lualine_x = {},
                        lualine_y = { 'location', 'progress', 'selectioncount' },
                        lualine_z = { 'mode' },
                    },
                    extensions = {}
                }
            },

            {
                'ibhagwan/fzf-lua',
                dependencies = { "nvim-tree/nvim-web-devicons" },
                opts = {
                    "hide",
                    grep = {
                        true,
                        rg_glob = true,
                        glob_flag = "--iglob",
                        glob_separator = "%s%-%-",
                        no_ignore = true,
                    },
                    winopts = {
                        true,
                        preview = {
                            layout = 'vertical',
                        },
                    },
                    oldfiles = {
                        true,
                        include_current_session = true,
                        no_ignore = true,
                    },
                    files = {
                        true,
                        no_ignore = true,
                    },
                    keymap = {
                        true,
                        fzf = {
                            true,
                            ["ctrl-j"] = "half-page-down",
                            ["ctrl-k"] = "half-page-up",
                            ["ctrl-a"] = "beginning-of-line",
                            ["ctrl-e"] = "end-of-line",
                            ["alt-a"] = "toggle-all",
                        },
                    },
                }
            },

            {
                "samjwill/nvim-unception",
            },

            {
                'numToStr/Comment.nvim',
                opts = {
                    mappings = {
                        basic = false,
                        extra = false,
                    },
                    toggler = {
                        line = 'gc'
                    },
                    opleader = {},
                    extra = {}
                }
            },


            { "williamboman/mason.nvim", opts = { PATH = "append" } },
            {
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                dependencies = { "williamboman/mason.nvim" },
                opts = { ensure_installed = { "gopls", "kotlin-lsp", "jdtls" }, run_on_start = true },
            },

            {
                "neovim/nvim-lspconfig",
                config = function()
                    vim.lsp.config("gopls", {
                        settings = { gopls = { staticcheck = true } },
                        root_markers = { "go.work", "go.mod", ".git" },
                    })

                    vim.lsp.config("jdtls", {
                        --cmd = { 'JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home jdtls' },
                        cmd_env = {
                            JAVA_HOME = "/Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home",
                        },
                        settings = {
                            java = {
                                -- Custom eclipse.jdt.ls options go here
                            },
                        },
                    })

                    -- kotlin added via plugin
                    -- jdtls is configured via plugin
                    vim.lsp.enable({ "gopls", "jdtls" })
                end,
            },
            {
                "hrsh7th/nvim-cmp",
                dependencies = {
                    "hrsh7th/cmp-nvim-lsp",
                    "hrsh7th/cmp-buffer",
                    "hrsh7th/cmp-path",
                },
                config = function()
                    local cmp = require("cmp")
                    cmp.setup {
                        mapping = cmp.mapping.preset.insert(),
                        sources = {
                            { name = "nvim_lsp" },
                            { name = "buffer" },
                            { name = "path" },
                        },
                    }
                end,
            },
            {
                "mfussenegger/nvim-jdtls", ft = "java"
            },
            {
                "AlexandrosAlexiou/kotlin.nvim",
                ft = { "kotlin" },
                config = function()
                    require("kotlin").setup {
                        -- Optional: Specify root markers for multi-module projects
                        root_markers = {
                            "gradlew",
                            ".git",
                            "mvnw",
                            "settings.gradle",
                        },
                        -- Optional: Specify a custom Java path to run the server
                        jre_path = "/Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home",
                        -- Optional: Specify additional JVM arguments
                        jvm_args = {
                            "-Xmx4g",
                        },
                    }
                end,
            }
            --PEND
        },

        install = { colorscheme = { "vscode" } },
        checker = { enabled = true, notify = false },
    })

