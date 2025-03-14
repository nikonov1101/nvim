vim.g.mapleader = " "

local with_opts = require("tools").keymap_opts

vim.keymap.set("n", "<Leader>w", "<cmd>wa<cr>", with_opts("write all"))
vim.keymap.set("n", "<Leader><leader>r", "<cmd>bufdo e<cr>", with_opts("reload all buffers"))
vim.keymap.set("n", "<Leader><leader>x", "<cmd>%bd|e#|bd#<cr>", with_opts("close all buffers"))

-- maybe this will help me
vim.keymap.set({ "n", "v" }, "<left>", "")
vim.keymap.set({ "n", "v" }, "<right>", "")
vim.keymap.set({ "n", "v" }, "<up>", "")
vim.keymap.set({ "n", "v" }, "<down>", "")

-- undo the undo
vim.keymap.set("n", "U", "<cmd>redo<cr>")

-- select left/right window with less keystrokes
vim.keymap.set("n", "<C-h>", "<C-w>h", with_opts())
vim.keymap.set("n", "<C-j>", "<C-w>j", with_opts())
vim.keymap.set("n", "<C-k>", "<C-w>k", with_opts())
vim.keymap.set("n", "<C-l>", "<C-w>l", with_opts())

-- normal, visual, operator-pending modes
local visuall = { "n", "x", "o" }

-- better half-page scrolling
vim.keymap.set(visuall, "gj", "<C-d>zz")
vim.keymap.set(visuall, "gk", "<C-u>zz")
-- s for start, e for end
vim.keymap.set(visuall, "gs", "^")
vim.keymap.set(visuall, "ge", "$")
vim.keymap.set(visuall, "gI", "`.") -- goto previous change, also "g;"

-- copy to a system clipboard
vim.keymap.set(visuall, "<leader>y", [["+y]])
vim.keymap.set(visuall, "<leader>Y", [["+Y]])

-- jump half-page up/down centers the cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- also center the search results,
-- zz to center, zv to open a fold
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- ALWAYS change and delete into blackhole register
vim.keymap.set("n", "c", "\"_c", with_opts())
vim.keymap.set("n", "dw", "\"_daw", with_opts())
vim.keymap.set("n", "dW", "\"_diW", with_opts())

-- change into a blackhole register
vim.keymap.set("n", "C", "\"_c$", with_opts())
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
