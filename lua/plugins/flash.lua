return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        search = {
            -- search/jump in all windows
            multi_window = false,
        },
        jump = {
            -- save location in the jumplist
            jumplist = true,
            -- automatically jump when there is only one match
            autojump = true,
        },
        label = {
            rainbow = {
                enabled = false,
                shade = 5, -- number between 1 and
            },
        },
        prompt = {
            enabled = false,
        },
        modes = {
            search = { enabled = false },
        },
    },
    keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
}
