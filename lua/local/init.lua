play = require("local.play")
local notify = require("fidget")

vim.keymap.set("n", "<Leader>P", function()
    local p = create_playground()
    notify.notify("go-play: created: " .. p)
    vim.cmd("edit +4 " .. p)
end, { desc = "create Go playground" })

vim.keymap.set("n", "<Leader>p", function()
    local p = last_playground()
    notify.notify("go-play: restoring: " .. p)
    vim.cmd("edit +4 " .. p)
end, { desc = "goto last Go playground" })