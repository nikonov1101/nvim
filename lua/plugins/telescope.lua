return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        {
            "nvim-telescope/telescope-live-grep-args.nvim",
            version = "^1.0.0",
        },
    },
    config = function()
        require("telescope").setup({
            defaults = {
                sorting_strategy = "ascending",
                results_title = false,
                layout_strategy = "vertical",
                anchor = "CENTER",
                layout_config = {
                    prompt_position = "top",
                    width = 0.94,
                    height = 0.94,
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({
                        -- even more opts
                    }),
                },
            },
        })
        require("telescope").load_extension("ui-select")

        local builtin = require("telescope.builtin")
        local find_git_files = function()
            local ok, _ = pcall(builtin.git_files)
            if not ok then builtin.find_files() end
        end

        -- both ^o and leader-o does the same, fixing bad habits
        vim.keymap.set("n", "<C-o>", find_git_files)
        vim.keymap.set("n", "<Leader>o", find_git_files)

        vim.keymap.set("n", "<C-p>", builtin.live_grep, { desc = "live grep" })

        vim.keymap.set("n", "<Leader>ff", builtin.find_files, { desc = "Find files" })

        vim.keymap.set("n", "<leader>fe", builtin.buffers, { desc = "buffers" })

        vim.keymap.set("n", "<leader>fc", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end, { desc = "find word under cursor" })

        vim.keymap.set(
            "n",
            "<leader>fF",
            function() builtin.find_files({ hidden = true }) end,
            { desc = "find all files" }
        )

        vim.keymap.set("n", "<leader>fg", function()
            require("telescope").extensions.live_grep_args.live_grep_args({
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--no-ignore", -- added this, the rest above are defaults
                },
            })
        end, { desc = "grep in all files" })
    end,
}
