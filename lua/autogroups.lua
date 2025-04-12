-- shamelwssly stolen here:
-- https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/init.lua
--
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local the_autoformat_group = augroup("the_autoformat_group", {})

autocmd("TextYankPost", {
    group = augroup("HighlightYank", {}),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 70,
        })
    end,
})

autocmd("BufWritePre", {
    group = the_autoformat_group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
autocmd("bufwritepre", {
    group = the_autoformat_group,
    pattern = "*.go",
    callback = function()
        local params = vim.lsp.util.make_range_params(0, "utf-8")
        params.context = { only = { "source.organizeImports" } }
        local timeout_ms = 1000
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
        for cid, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                    vim.lsp.util.apply_workspace_edit(r.edit, enc)
                end
            end
        end

        vim.lsp.buf.format({ async = false })
    end,
})
autocmd("bufwritepre", {
    group = the_autoformat_group,
    pattern = "*.lua",
    callback = function() require("stylua-nvim").format_file() end,
})

autocmd("LspAttach", {
    group = the_autoformat_group,
    callback = function(e)
        local tele = require("telescope.builtin")
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
        vim.keymap.set("n", "grr", "<cmd>Telescope lsp_references<cr>", opts)
        vim.keymap.set("n", "grn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "gra", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "grI", "<cmd>Telescope lsp_incoming_calls<cr>", opts)
        vim.keymap.set("n", "grO", "<cmd>Telescope lsp_outgoing_calls<cr>", opts)
        vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)

        vim.keymap.set("n", "<leader>ls", function() tele.lsp_document_symbols() end, opts)
        vim.keymap.set("n", "<leader>ld", function() tele.diagnostics() end, opts)
        vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, opts)
        vim.keymap.set("n", "<leader>lh", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>lg", function() vim.lsp.buf.signature_help() end, opts)

        vim.keymap.set("n", "]e", function() vim.diagnostic.jump({ count = 1 }) end, opts)
        vim.keymap.set("n", "[e", function() vim.diagnostic.jump({ count = -1 }) end, opts)

        -- vim.lsp.handlers["textDocument/references"] = function(_, _, _) tele.lsp_references() end
        -- vim.lsp.handlers["textDocument/implementation"] = function(_, _, _) tele.lsp_implementations() end
        -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        --     border = "single",
        --     focus = false,
        --     focusable = false,
        -- })
        -- -- todo: move to lsp.lua??
        -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        --     border = "single",
        --     focus = false,
        --     focusable = false,
        -- })
    end,
})
