-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- custom keymaps
local opts = { noremap = true, silent = true }
-- search everything
vim.api.nvim_set_keymap("n", "<C-o>", ":Telescope find_files<cr>", opts)
vim.api.nvim_set_keymap("n", "<C-f>", ":Telescope current_buffer_fuzzy_find<cr>", opts)
vim.api.nvim_set_keymap("n", "<C-_>", ":Telescope live_grep<cr>", opts)
-- duplicate as C-/ because C-_ seems broken on macOS
vim.api.nvim_set_keymap("n", "<C-/>", ":Telescope live_grep<cr>", opts)

-- << and >> navigate buffers, works much better than [-b for me
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
