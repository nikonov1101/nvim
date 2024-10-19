vim.g.nvim_tree_show_icons = {
    git = 0,
    folders = 0,
    files = 0,
    folder_arrows = 0,
}

vim.keymap.set("n", "<Leader>o", "<cmd>Neotree filesystem reveal left<cr>", {})

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        tabs_layout = "active",
        add_blank_line_at_top = false,
        use_popups_for_input = false,
        popup_border_style = "single",
        auto_clean_after_session_restore = true,
        close_if_last_window = true,
        source_selector = {
            winbar = false,
            statusline = false,
            sources = {
                { source = "filesystem" },
                { source = "git_status" },
                { source = "document_symbols" },
            },
        },
        default_component_configs = {
            name = {
                trailing_slash = true,
            },
            modified = {
                symbol = "",
                highlight = "NeoTreeModified",
            },
            icon = {
                folder_closed = "",
                folder_open = "",
                folder_empty = "",
                default = "",
            },
            git_status = {
                symbols = {
                    added     = "",
                    modified  = "",
                    deleted   = "", -- this can only be used in the git_status source
                    renamed   = "", -- this can only be used in the git_status source
                    -- Status type
                    untracked = "",
                    ignored   = "",
                    unstaged  = "",
                    staged    = "",
                    conflict  = "",
                },
            },
        },
        filesystem = {
            group_empty_dirs = true,
            follow_current_file = {
                enabled = false,         -- This will find and focus the file in the active buffer every time
                leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
            },
            filtered_items = {
                visible = true,
                never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                    --".DS_Store",
                    --"thumbs.db"
                },
            },
        },
        document_symbols = {
            follow_cursor = true,
        },
        window = {
            position = "left",
            width = 34,
            mappings = {
                ["n"] = "add",
                ["ga"] = "git_add_file",
                ["gr"] = "git_revert_file",
            },
        },
    },
}
