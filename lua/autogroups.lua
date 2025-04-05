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
        local params = vim.lsp.util.make_range_params()
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

