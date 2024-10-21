return {
    "stevearc/resession.nvim",
    lazy = false,
    priority = 42,
    config = function()
        local rs = require("resession")
        local fidget = require("fidget")

        rs.setup({
            options = {
                "binary",
                "bufhidden",
                "buflisted",
                "cmdheight",
                "diff",
                "filetype",
                "modifiable",
                "previewwindow",
                "readonly",
                "scrollbind",
                "winfixheight",
                "winfixwidth",
            },
            extensions = {
                quickfix = {},
            },
        })

        vim.keymap.set("n", "<leader>Sa", rs.save, { desc = "save session" })
        vim.keymap.set("n", "<leader>Sl", rs.load, { desc = "load session" })
        vim.keymap.set("n", "<leader>Sd", rs.delete, { desc = "delete session" })

        -- autosave
        vim.api.nvim_create_autocmd("VimLeavePre", {
            callback = function()
                rs.save(vim.fn.getcwd(), { dir = "dirsession", notify = true })
            end,
        })
        -- auto load
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function()
                -- Only load the session if nvim was started with no args
                if vim.fn.argc(-1) == 0 then
                    -- Save these to a different directory, so our manual sessions don't get polluted
                    fidget.notify("session loaded")
                    rs.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = false })
                end
            end,
            nested = true,
        })
    end,
}
