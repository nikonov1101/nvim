return {
    cmd = { "/home/alex/.local/share/nvim/mason/packages/lua-language-server/lua-language-server" },
    root_markers = { "init.lua", "stylua.toml" },
    filetypes = { "lua" },
    settings = {
        Lua = {
            telemetry = { enabled = false },
            runtime = { version = "Lua 5.1" },
            diagnostics = {
                globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
            },
        },
    },
}
