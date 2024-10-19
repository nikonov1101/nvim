-- shamelwssly stolen here:
-- https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/init.lua
--
local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup('ThePrimeagen', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})


autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 70,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = ThePrimeagenGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
autocmd({ "BufWritePre" }, {
    group = ThePrimeagenGroup,
    pattern = "*",
    command = [[:lua vim.lsp.buf.format()]],
})

-- rebuild or just define in keys.lua
autocmd('LspAttach', {
    group = ThePrimeagenGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "grn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>ls", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, opts)
        vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<SC-K>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[e", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]e", function() vim.diagnostic.goto_prev() end, opts)
    end
})
