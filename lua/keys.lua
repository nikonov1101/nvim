vim.g.mapleader = " "

local with_opts = require("tools").keymap_opts

vim.keymap.set("n", "<Leader>w", "<cmd>wa<cr>", with_opts("write all"))
vim.keymap.set("n", "<Leader>q", "<cmd>qa<cr>", with_opts("exit all"))

-- maybe this will help me
vim.keymap.set({ "n", "v" }, "<left>", "")
vim.keymap.set({ "n", "v" }, "<right>", "")
vim.keymap.set({ "n", "v" }, "<up>", "")
vim.keymap.set({ "n", "v" }, "<down>", "")

-- better movements in insert-mode
vim.keymap.set("i", "jj", "<Esc>", with_opts())
vim.keymap.set("i", "OO", "<Esc>o", with_opts())
vim.keymap.set("i", "II", "<Esc>I", with_opts())
vim.keymap.set("i", "AA", "<Esc>A", with_opts())

-- select left/right window with less keystrokes
vim.keymap.set("n", "<C-h>", "<C-w>h", with_opts())
vim.keymap.set("n", "<C-l>", "<C-w>l", with_opts())

-- copy to a system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]])

-- jump half-page up/down centers the cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- also center the search results,
-- zz to center, zv to open a fold
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- ALWAYS change and delete into blackhole register
vim.keymap.set("n", "c", "\"_c", with_opts())
vim.keymap.set("n", "dw", "\"_diw", with_opts())
vim.keymap.set("n", "dW", "\"_diW", with_opts())

-- change into a blackhole register
vim.keymap.set("n", "C", "\"_ciw", with_opts())
vim.keymap.set("n", "cc", "\"_c$", with_opts())
vim.keymap.set("n", "cw", "\"_ciw", with_opts())
vim.keymap.set("n", "cW", "\"_ciW", with_opts())
vim.keymap.set("n", "c\"", "\"_ci\"", with_opts())
vim.keymap.set("n", "c'", "\"_ci'", with_opts())
vim.keymap.set("n", "c(", "\"_ci(", with_opts())
vim.keymap.set("n", "c{", "\"_ci{", with_opts())
vim.keymap.set("n", "c[", "\"_ci[", with_opts())

-- yank faster
vim.keymap.set("n", "yw", "yiw", with_opts())
vim.keymap.set("n", "yW", "yiW", with_opts())
vim.keymap.set("n", "y{", "yi{", with_opts())
vim.keymap.set("n", "y(", "yi(", with_opts())
vim.keymap.set("n", "y[", "yi[", with_opts())
vim.keymap.set("n", "y\"", "yi\"", with_opts())
vim.keymap.set("n", "y'", "yi'", with_opts())

-- visual faster
vim.keymap.set("n", "vw", "viw", with_opts())
vim.keymap.set("n", "vW", "viW", with_opts())
vim.keymap.set("n", "v{", "vi{", with_opts())
vim.keymap.set("n", "v(", "vi(", with_opts())
vim.keymap.set("n", "v[", "vi[", with_opts())
vim.keymap.set("n", "v\"", "vi\"", with_opts())
vim.keymap.set("n", "v'", "vi'", with_opts())

-- [[ and ]] jumps back and forth over history
vim.keymap.set("n", "[[", ":lua vim.api.nvim_command('normal! <C-o>')<cr>", with_opts("Go backward in history"))
vim.keymap.set(
    "n",
    "]]",
    -- lua interprets C-i in a weird way, so the line below remaps it.
    -- thanks, chatGPT
    ":lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-i>', true, false, true), 'n', true)<cr>",
    with_opts("Go forward in history")
)
-- replace visual selection with a given text,
-- from loveoverflow <3
-- https://stackoverflow.com/questions/676600/vim-search-and-replace-selected-text
vim.keymap.set("v", "<C-r>", "\"hy:%s/<C-r>h//g<left><left>")
