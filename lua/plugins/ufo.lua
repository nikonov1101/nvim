return {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        "kevinhwang91/promise-async",
    },
    config = function()
        local ufo = require("ufo")

        vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        -- hide fold column
        vim.o.foldcolumn = "0"
        vim.opt.foldmethod = "indent"

        ufo.setup({
            provider_selector = function(_, _, _) return { "treesitter", "indent" } end,
        })

        vim.keymap.set("n", "zR", ufo.openAllFolds)
        vim.keymap.set("n", "zM", ufo.closeAllFolds)
    end,
}
