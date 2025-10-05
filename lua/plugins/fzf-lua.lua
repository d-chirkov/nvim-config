return {
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
}
