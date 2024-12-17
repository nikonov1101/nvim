return {
    "echasnovski/mini.move",
    version = "*",
    event = "VeryLazy",
    keys = function(_, keys)
        local plugin = require("lazy.core.config").spec.plugins["mini.move"]
        local opts = require("lazy.core.plugin").values(plugin, "opts", false) -- resolve mini.clue options
        -- Populate the keys based on the user's options
        local mappings = {
            { opts.mappings.line_left, desc = "Move line left" },
            { opts.mappings.line_right, desc = "Move line right" },
            { opts.mappings.line_down, desc = "Move line down" },
            { opts.mappings.down, desc = "Move selection down", mode = "v" },
            { opts.mappings.up, desc = "Move selection up", mode = "v" },
            { opts.mappings.line_up, desc = "Move line up" },
            { opts.mappings.left, desc = "Move selection left", mode = "v" },
            { opts.mappings.right, desc = "Move selection right", mode = "v" },
        }
        mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)
        return vim.list_extend(mappings, keys)
    end,
    opts = {
        mappings = {
            left = "<",
            right = ">",
            down = "J",
            up = "K",
            line_left = "<",
            line_right = ">",
            line_down = "J",
            line_up = "K",
        },
    },
}
