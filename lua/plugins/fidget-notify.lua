return {
    "j-hui/fidget.nvim",
    opts = {
        progress = {
            suppress_on_insert = false,
            ignore_empty_message = false,
            display = {
                done_icon = "",
                render_limit = 25,
                done_ttl = 6,
            },
        },
        notification = {
            override_vim_notify = true,
            view = {
                stack_upwards = false,
                icon_separator = "",
            },
            window = {
                winblend = 10,
                align = "top",
                x_padding = 0,
                y_padding = 0,
            },
        },
    },
}
