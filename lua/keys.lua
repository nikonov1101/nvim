vim.g.mapleader = " "

-- custom keymaps
local function with_opts(s)
    local ta = { noremap = true, silent = true }
    if s ~= "" then ta["desc"] = s end
    return ta
end

vim.keymap.set("n", "<Leader>e", vim.cmd.Vex, with_opts("open Ex"))
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- jump half-page up/down centers the cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- also center the search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- << and >> navigate buffers, works much better than [-b for me
vim.keymap.set("n", "<<", ":bp<cr>", with_opts "To to left buffer")
vim.keymap.set("n", ">>", ":bn<cr>", with_opts "To to right buffer")

-- ALWAYS change and delete into blackhole register
vim.keymap.set("n", "d", '"_d', with_opts())
vim.keymap.set("n", "c", '"_c', with_opts())
vim.keymap.set("n", "dw", '"_diw', with_opts())

-- change into a blackhole register
vim.keymap.set("n", "C", '"_ciw', with_opts())
vim.keymap.set("n", 'c"', '"_ci"', with_opts())
vim.keymap.set("n", "c'", '"_ci\'', with_opts())
vim.keymap.set("n", "c(", '"_ci(', with_opts())
vim.keymap.set("n", "c{", '"_ci{', with_opts())
vim.keymap.set("n", "c[", '"_ci[', with_opts())

-- yank faster
vim.keymap.set("n", "yw", "yiw", with_opts())
vim.keymap.set("n", "y{", "yi{", with_opts())
vim.keymap.set("n", "y(", "yi(", with_opts())
vim.keymap.set("n", "y[", "yi[", with_opts())
vim.keymap.set("n", 'y"', 'yi"', with_opts())
vim.keymap.set("n", "y'", "yi'", with_opts())

vim.keymap.set("n", "<leader>rr", ":!go run %<cr>", with_opts "go run this file")
vim.keymap.set("n", "<leader>rb", ":!go test -v -bench $(dirname %)<cr>", with_opts "go bench this file")
vim.keymap.set("n", "<leader>rt", ":TestNearest<cr>", with_opts "go test nearest test")
vim.keymap.set("n", "<leader>rT", ":TestFile<cr>", with_opts "go test nearest test")

-- [[ and ]] jumps back and forth over history
vim.keymap.set("n", "[[", ":lua vim.api.nvim_command('normal! <C-o>')<cr>", with_opts "Go backward in history")
vim.keymap.set(
    "n",
    "]]",
    -- lua interprets C-i in a weird way, so the line below remaps it.
    -- thanks, chatGPT
    ":lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-i>', true, false, true), 'n', true)<cr>",
    with_opts "Go forward in history"
)
