vim.g.mapleader = " "

local with_opts = require("tools").keymap_opts
-- normal, visual, operator-pending modes
local vis = { "n", "x", "o" }
local all = { "n", "i", "v", "x", "o" }

-- picking good habits faster --
vim.keymap.set(vis, "<left>", "")
vim.keymap.set(vis, "<right>", "")
vim.keymap.set(vis, "<up>", "")
vim.keymap.set(vis, "<down>", "")
vim.keymap.set(all, "<f1>", "")
vim.keymap.set(all, "<PageUp>", "")
vim.keymap.set(all, "<PageDown>", "")

-- copy to a system clipboard
vim.keymap.set(vis, "<leader>y", [["+y]])
--
-- double leader as a safety measure
--
vim.keymap.set("n", "<Leader><leader>r", "<cmd>bufdo e<cr>", with_opts("reload all buffers"))
vim.keymap.set("n", "<Leader><leader>x", "<cmd>%bd|e#|bd#<cr>", with_opts("close all buffers"))
-- copy the whole line into the system clipboard
vim.keymap.set("n", "<Leader><leader>y", [["+Y]], with_opts("close all buffers"))

-- undo the undo
vim.keymap.set("n", "U", "<cmd>redo<cr>")

-- a for start, e for end, same as for shell navigation
vim.keymap.set(vis, "ga", "^ze")
vim.keymap.set(vis, "ge", "$")
-- semantic - Go Bracket
vim.keymap.set(vis, "gb", "%")
-- semantic - Go Matching
vim.keymap.set(vis, "gm", "*")

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

-- replace visual selection with a given text,
-- from loveoverflow <3
-- https://stackoverflow.com/questions/676600/vim-search-and-replace-selected-text
vim.keymap.set("v", "<C-r>", "\"hy:%s/<C-r>h//g<left><left>")
