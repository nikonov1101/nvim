-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- custom keymaps
local function with_opts(s)
  local ta = { noremap = true, silent = true }
  if s ~= "" then ta["desc"] = s end
  return ta
end

--- TODO: re-group that file in some meaningful way.

-- search everything
vim.keymap.set("n", "<C-o>", ":Telescope git_files<cr>", with_opts())
vim.keymap.set("n", "<C-f>", ":Telescope current_buffer_fuzzy_find<cr>", with_opts())
vim.keymap.set("n", "<C-_>", ":Telescope live_grep<cr>", with_opts())
-- duplicate as C-/ because C-_ seems broken on macOS
vim.keymap.set("n", "<C-/>", ":Telescope live_grep<cr>", with_opts())

-- go to implementation
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, with_opts())
-- return back Rename to LSP menu
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, with_opts "Rename symbol")
-- make Ctrl+K works in both insert and normal modes
-- same hotkey for insert mode: see `toggle_key` @ ./plugins/lsp_signature.lua
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, with_opts())

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

-- change into a blackhole register
vim.keymap.set("n", "C", '"_ciw', with_opts())
vim.keymap.set("n", 'c"', '"_ci"', with_opts())
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

vim.keymap.set({ "n", "v" }, "mm", "<cmd>BookmarksMark<cr>", { desc = "Mark current line into active BookmarkList." })
vim.keymap.set({ "n", "v" }, "mo", "<cmd>BookmarksGoto<cr>", { desc = "Go to bookmark at current active BookmarkList" })

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
