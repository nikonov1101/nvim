return {
    'numToStr/Comment.nvim',
    config = function()
        local c = require("Comment")
        c.setup()

        vim.keymap.set("n", "<Leader>/", function()
                return require("Comment.api").call(
                    "toggle.linewise." .. (vim.v.count == 0 and "current" or "count_repeat"),
                    "g@$"
                )()
            end,

            {
                expr = true,
                silent = true,
                desc = "Toggle comment line"
            })

        vim.keymap.set("x", "<Leader>/",
            "<Esc><Cmd>lua require('Comment.api').locked('toggle.linewise')(vim.fn.visualmode())<CR>",
            { desc = "Toggle comment" })
    end
}
