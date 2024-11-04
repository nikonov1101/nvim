return {
    "klen/nvim-test",
    config = function()
        require("nvim-test").setup({
            termOpts = {
                direction = "vertical",
                width = 60,
                go_back = true,
                stopinsert = "auto",
                keep_one = true,
            },
        })

        local with_opts = require("tools").keymap_opts
        vim.keymap.set("n", "<leader>rr", ":!go run %<cr>", with_opts("go run this file"))
        vim.keymap.set("n", "<leader>rb", ":!go test -v -bench $(dirname %)<cr>", with_opts("go bench this file"))
        vim.keymap.set("n", "<leader>rt", ":TestNearest<cr>", with_opts("go test nearest test"))
        vim.keymap.set("n", "<leader>rT", ":TestFile<cr>", with_opts("go test nearest test"))
    end,
}
