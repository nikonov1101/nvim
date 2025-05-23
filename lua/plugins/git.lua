return {
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        config = function()
            local gitsigns = require("gitsigns")
            gitsigns.setup({
                signs_staged_enable = true,
                signcolumn = true,
                numhl = true,
                current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`

                on_attach = function(bufnr)
                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "]c", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "]c", bang = true })
                        else
                            gitsigns.nav_hunk("next", { target = "all" })
                        end
                    end)

                    map("n", "[c", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "[c", bang = true })
                        else
                            gitsigns.nav_hunk("prev", { target = "all" })
                        end
                    end)

                    -- Actions
                    map({ "n", "v" }, "<leader>gg", "<cmd>Gitsigns<cr>", { desc = "gitsigns pop-up" })
                    map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "stage hunk" })
                    map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "reset hunk" })
                    map(
                        "v",
                        "<leader>gs",
                        function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                        { desc = "stage hunk" }
                    )
                    map(
                        "v",
                        "<leader>gr",
                        function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                        { desc = "reset hunk" }
                    )
                end,
            })
        end,
    },
    {
        "sindrets/diffview.nvim",
        config = function()
            vim.keymap.set("n", "<leader><leader>g", "<cmd>:DiffviewOpen -uno<cr>")
            vim.keymap.set("n", "<leader><leader>u", "<cmd>:DiffviewOpen<cr>")
            vim.keymap.set("n", "<leader><leader>c", "<cmd>:DiffviewClose<cr>")
            vim.keymap.set("n", "<leader><leader>h", "<cmd>:DiffviewFileHistory %<cr>")
            vim.keymap.set("n", "<leader><leader>k", function() require("local.commit").show() end)

            require("diffview").setup({
                use_icons = false,
                file_panel = {
                    listing_style = "list",
                    win_config = {
                        position = "left",
                        width = 33,
                        win_opts = {},
                    },
                },
                default_args = { -- Default args prepended to the arg-list for the listed commands
                    DiffviewOpen = {
                        "--imply-local",
                    },
                    DiffviewFileHistory = {},
                },
                keymaps = {
                    disable_defaults = false, -- use only keymaps defined below?
                    view = {},
                    file_panel = {},
                    file_history_panel = {},
                },
            })
        end,
    },
}
