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

                    -- view with telescope, V for VCS
                    local tele = require("telescope.builtin")
                    map("n", "<leader>vL", tele.git_bcommits, { desc = "git log (buffer)" })
                    map("n", "<leader>vl", tele.git_commits, { desc = "git log (all)" })
                    map("n", "<leader>vb", tele.git_branches, { desc = "git branches" })
                    map("n", "<leader>vs", "<cmd>Neotree float git_status<cr>", { desc = "git status" })

                    -- Actions
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
                    map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "stage buffer" })
                    map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "reset buffer" })
                    map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "preview hunk" })

                    -- Text object
                    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
                end,
            })
        end,
    },
    {
        "sindrets/diffview.nvim",
        config = function()
            vim.keymap.set("n", "<leader>GG", "<cmd>:DiffviewOpen -uno<cr>")
            vim.keymap.set("n", "<leader>GU", "<cmd>:DiffviewOpen<cr>")
            vim.keymap.set("n", "<leader>GC", "<cmd>:DiffviewClose<cr>")
            vim.keymap.set("n", "<leader>GF", "<cmd>:DiffviewFileHistory %<cr>")

            local actions = require("diffview.actions")
            -- https://github.com/sindrets/diffview.nvim?tab=readme-ov-file#configuration
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
                    DiffviewOpen = {},
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
