vim.opt_local.textwidth = 80
vim.opt_local.colorcolumn = "+1"

local function keycode(name) return vim.api.nvim_replace_termcodes(name, true, true, true) end
local esc = keycode("<esc>") -- ]^
local ret = keycode("<return>") -- ]M

-- persist @f to format markdown
-- thanks for inspiration:
-- https://www.youtube.com/watch?v=Y3XWijJgdJs
vim.fn.setreg("f", "gg/^---" .. ret .. "jVGgq" .. esc .. ":w" .. ret)
-- persist @u wrap visual with link tag, e.g
-- test -> [test](I), where I is the final cursor position
vim.fn.setreg("u", "di[]()" .. esc .. "hhhplla")
