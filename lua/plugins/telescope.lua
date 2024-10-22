return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
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
        })

        local builtin = require('telescope.builtin')
        vim.keymap.set("n", "<C-o>", builtin.git_files, {})
        vim.keymap.set("n", "<C-S-O>", builtin.find_files, {})
        vim.keymap.set("n", "<C-f>", builtin.current_buffer_fuzzy_find, {})
        vim.keymap.set("n", "<C-_>", builtin.live_grep, {})
        -- duplicate as C-/ because C-_ seems broken on macOS
        vim.keymap.set("n", "<C-/>", builtin.live_grep, {})

        vim.keymap.set('n', '<leader>fc', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end, { desc = "find word under cursor" })
        vim.keymap.set('n', '<leader>ft', builtin.help_tags, {})
    end
}
