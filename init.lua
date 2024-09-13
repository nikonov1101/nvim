-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

-- custom keymaps
local opts = { noremap = true, silent = true }
-- search everything
vim.api.nvim_set_keymap("n", "<C-o>", ":Telescope find_files<cr>", opts)
vim.api.nvim_set_keymap("n", "<C-f>", ":Telescope current_buffer_fuzzy_find<cr>", opts)
vim.api.nvim_set_keymap("n", "<C-_>", ":Telescope live_grep<cr>", opts)
-- duplicate as C-/ because C-_ seems broken on macOS
vim.api.nvim_set_keymap("n", "<C-/>", ":Telescope live_grep<cr>", opts)

-- << and >> navigate buffers
vim.api.nvim_set_keymap("n", "<<", ":bp<cr>", opts)
vim.api.nvim_set_keymap("n", ">>", ":bn<cr>", opts)

-- [[ and ]] jumps back and forth over history
vim.api.nvim_set_keymap("n", "[[", ":lua vim.api.nvim_command('normal! <C-o>')<cr>", opts)
vim.api.nvim_set_keymap(
  "n",
  "]]",
  -- lua interprets C-i in a weird way, so the line below remaps it.
  -- thanks, chatGPT
  ":lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-i>', true, false, true), 'n', true)<cr>",
  opts
)

require "lazy_setup"
require "polish"
