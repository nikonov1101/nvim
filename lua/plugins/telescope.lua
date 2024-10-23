return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
        require('telescope').setup({
            defaults = {
                sorting_strategy = "ascending",
                results_title = false,
                layout_strategy = "horizontal",
                prompt_position = "top",
                anchor = "CENTER",
                layout_config = {
                    width = 0.9,
                    height = 0.9,
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {
                        -- even more opts
                    } }
            }
        })
        require("telescope").load_extension("ui-select")

        local builtin = require('telescope.builtin')
        vim.keymap.set("n", "<C-o>", function()
            local ok, _ = pcall(builtin.git_files)
            if not ok then
                builtin.find_files()
            end
        end, {})
        vim.keymap.set("n", "<C-f>", builtin.current_buffer_fuzzy_find, {})
        vim.keymap.set("n", "<C-_>", builtin.live_grep, {})
        -- duplicate as C-/ because C-_ seems broken on macOS
        vim.keymap.set("n", "<C-/>", builtin.live_grep, {})

        vim.keymap.set("n", "<Leader>ff", builtin.find_files, { desc = "Find files" })
        vim.keymap.set('n', '<leader>fc', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end, { desc = "find word under cursor" })
    end
}
