local notify = require("fidget")
local play = require("local.play")
local line = require("local.line")

line.setup()
play.setup(vim.env.HOME .. "/src/go-playground")

vim.keymap.set("n", "<Leader>P", function()
    local p = play.create_playground()
    notify.notify("go-play: created: " .. p, nil, { group = "go-play" })
    vim.cmd("edit +4 " .. p)
end, { desc = "create Go playground" })

vim.keymap.set("n", "<Leader>p", function()
    local p = play.last_playground()
    notify.notify("go-play: restoring: " .. p, nil, { group = "go-play" })
    vim.cmd("edit +4 " .. p)
end, { desc = "goto last Go playground" })
