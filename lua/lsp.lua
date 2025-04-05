local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

vim.diagnostic.config({
    virtual_text = true,
    update_in_insert = true,
    float = {
        focusable = false,
        scope = "line", -- or "cursor" to show only hovered
        border = "single",
        source = true,
        header = "",
        prefix = "",
    },
})

autocmd("LspAttach", {
    group = augroup("the_lsp_group", {}),
    callback = function(e)
        local tele = require("telescope.builtin")
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
        vim.keymap.set("n", "grr", function() vim.lsp.buf.references() end, opts)
        -- TODO: in\out calls
        vim.keymap.set("n", "grn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "gra", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>ls", function() tele.lsp_document_symbols() end, opts)
        vim.keymap.set("n", "<leader>ld", function() tele.diagnostics() end, opts)
        vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, opts)
        vim.keymap.set("n", "<leader>lh", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>lg", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev() end, opts)

        vim.lsp.handlers["textDocument/references"] = function(_, _, _) tele.lsp_references() end
        vim.lsp.handlers["textDocument/implementation"] = function(_, _, _) tele.lsp_implementations() end
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "single",
            focus = false,
            focusable = false,
        })
        -- todo: move to lsp.lua??
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = "single",
            focus = false,
            focusable = false,
        })
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

vim.lsp.enable({ "clangd", "gopls", "lua_ls" })
