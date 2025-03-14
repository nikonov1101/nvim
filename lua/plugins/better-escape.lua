return {
    "max397574/better-escape.nvim",
    config = function()
        -- lua, default settings
        require("better_escape").setup({
            timeout = vim.o.timeoutlen,
            default_mappings = false,
            mappings = {
                i = {
                    j = {
                        k = "<Esc>",
                        j = "<Esc>",
                    },
                    O = { O = "<esc>o" },
                    I = { I = "<esc>I" },
                    A = { A = "<esc>A" },
                },
                c = {
                    j = {
                        k = "<Esc>",
                        j = "<Esc>",
                    },
                },
                s = {
                    j = {
                        k = "<Esc>",
                    },
                },
            },
        })
    end,
}
