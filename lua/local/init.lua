local notify = require("fidget")
local play = require("local.play")
local line = require("local.line")
local tools = require("tools")

line.setup()
play.setup(vim.env.HOME .. "/src/go-playground")

vim.keymap.set("n", "<Leader>pP", function()
    local p = play.create_playground()
    notify.notify("go-play: created: " .. p, nil, { group = "go-play" })
    vim.cmd("edit +4 " .. p)
end, tools.keymap_opts("create Go playground"))

vim.keymap.set("n", "<Leader>pp", function()
    local p = play.last_playground()
    notify.notify("go-play: restoring: " .. p, nil, { group = "go-play" })
    vim.cmd("edit +4 " .. p)
end, tools.keymap_opts("goto last Go playground"))

vim.keymap.set("n", "<Leader>pt", function() vim.cmd("edit ~/focus") end, tools.keymap_opts("open global TODO file"))
