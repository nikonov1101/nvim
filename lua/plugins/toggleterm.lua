return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        -- toggle hotkey
        vim.keymap.set("n", "<Leader>t", "<cmd>:ToggleTerm direction=float<cr>i", {})
        -- C-w is for window, t is for terminal, note 'i' at the end for INSERT mode
        vim.keymap.set("n", "<C-w>t", "<cmd>:ToggleTerm direction=float<cr>i", {})

        function _G.set_terminal_keymaps()
            -- keybindings inside the terminal
            local opts = { buffer = 0 }
            -- leave insert mode inside the terminal
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
            -- double esc hides the terminal
            vim.keymap.set('t', '<esc><esc>', [[<C-\><C-n><C-w><C-w>]], opts)
        end

        -- if you only want these mappings for toggle term use term://*toggleterm#* instead
        vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

        require("toggleterm").setup({
            auto_scroll = false,
            direction = 'float',
            start_in_insert = true,
            insert_mappings = true,   -- whether or not the open mapping applies in insert mode
            terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
        })
    end
}
