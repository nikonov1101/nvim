-- shamelwssly stolen here:
-- https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/init.lua
--
local augroup = vim.api.nvim_create_augroup
local the_autoformat_group = augroup('the_autoformat_group', {})

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

autocmd("BufWritePre", {
    group = the_autoformat_group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
autocmd("BufWritePre", {
    group = the_autoformat_group,
    pattern = "*",
    callback = function()
        vim.lsp.buf.format()
    end,
})
autocmd("BufWritePre", {
    group = the_autoformat_group,
    pattern = "*.go",
    callback = function()
        vim.lsp.buf.code_action { context = { only = { 'source.organizeImports' } }, apply = true }
        vim.lsp.buf.code_action { context = { only = { 'source.fixAll' } }, apply = true }
    end
})

autocmd('LspAttach', {
    group = the_autoformat_group,
    callback = function(e)
        local tele = require("telescope.builtin")
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
        vim.keymap.set("n", "grr", function() vim.lsp.buf.references() end, opts)
        -- TODO: in\out calls
        vim.keymap.set("n", "grn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>ls", function() tele.lsp_document_symbols() end, opts)
        vim.keymap.set("n", "<leader>ld", function() tele.diagnostics() end, opts)
        vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, opts)
        vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<SC-K>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[e", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]e", function() vim.diagnostic.goto_prev() end, opts)

        vim.lsp.handlers["textDocument/references"] = function(_, _, _)
            tele.lsp_references()
        end
        vim.lsp.handlers["textDocument/implementation"] = function(_, _, _)
            tele.lsp_implementations()
        end
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover, {
                border = "single",
                focus = false,
                focusable = false,
            }
        )
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
            vim.lsp.handlers.signature_help, {
                border = "single",
                focus = false,
                focusable = false,
            }
        )
    end
})
