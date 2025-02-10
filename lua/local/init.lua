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

-- semantic: "t" for Todo
vim.keymap.set("n", "<Leader>pt", function() vim.cmd("tabe ~/focus") end, tools.keymap_opts("open global TODO file"))
-- semantic: "s" for Scratch
vim.keymap.set(
    "n",
    "<Leader>ps",
    function() vim.cmd("tabe | setlocal buftype=nofile noswapfile bufhidden=delete") end,
    tools.keymap_opts("new scratch file")
)
