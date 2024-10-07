-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- show references with Telescope, much better to see the context
vim.lsp.handlers["textDocument/references"] = function(_, _, _) require("telescope.builtin").lsp_references() end
vim.lsp.handlers["textDocument/implementation"] = function(_, _, _) require("telescope.builtin").lsp_implementations() end

-- todo: fix this, it breaks Rename and Go to definition/implementation
--
-- tune up parameters to Go LSP
-- require("lspconfig").gopls.setup {
--   single_file_support = true,
--   settings = {
--     gopls = {
--       completeUnimported = true,
--       usePlaceholders = false,
--       analyses = {
--         unusedparams = true,
--       },
--       staticcheck = true,
--       gofumpt = true,
--     },
--   },
-- }

-- custom keymaps
local function with_opts(s)
  local ta = { noremap = true, silent = true }
  if s ~= "" then ta["desc"] = s end
  return ta
end

--- TODO: re-group that file in some meaningful way.

-- search everything
vim.api.nvim_set_keymap("n", "<C-o>", ":Telescope find_files<cr>", with_opts())
vim.api.nvim_set_keymap("n", "<C-f>", ":Telescope current_buffer_fuzzy_find<cr>", with_opts())
vim.api.nvim_set_keymap("n", "<C-_>", ":Telescope live_grep<cr>", with_opts())
-- duplicate as C-/ because C-_ seems broken on macOS
vim.api.nvim_set_keymap("n", "<C-/>", ":Telescope live_grep<cr>", with_opts())

-- go to implementation
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, with_opts())
-- return back Rename to LSP menu
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, with_opts "Rename symbol")
-- make Ctrl+K works in both insert and normal modes
-- same hotkey for insert mode: see `toggle_key` @ ./plugins/lsp_signature.lua
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, with_opts())

-- << and >> navigate buffers, works much better than [-b for me
vim.api.nvim_set_keymap("n", "<<", ":bp<cr>", with_opts "To to left buffer")
vim.api.nvim_set_keymap("n", ">>", ":bn<cr>", with_opts "To to right buffer")
-- change into a blackhole register
vim.api.nvim_set_keymap("n", "C", '"_ciw', with_opts())
vim.api.nvim_set_keymap("n", 'c"', '"_ci"', with_opts())
vim.api.nvim_set_keymap("n", "c(", '"_ci(', with_opts())
vim.api.nvim_set_keymap("n", "c)", '"_ci)', with_opts())
vim.api.nvim_set_keymap("n", "c{", '"_ci{', with_opts())
vim.api.nvim_set_keymap("n", "c}", '"_ci}', with_opts())
-- delete into a the blackhole register
vim.api.nvim_set_keymap("n", "dd", '"_dd', with_opts())
vim.api.nvim_set_keymap("n", "D", '"_diw', with_opts())
vim.api.nvim_set_keymap("n", "x", '"_x', with_opts())

vim.api.nvim_set_keymap("n", "<leader>rr", ":!go run %<cr>", with_opts "go run this file")
vim.api.nvim_set_keymap("n", "<leader>rt", ":TestNearest<cr>", with_opts "go test nearest test")

vim.keymap.set({ "n", "v" }, "mm", "<cmd>BookmarksMark<cr>", { desc = "Mark current line into active BookmarkList." })
vim.keymap.set({ "n", "v" }, "mo", "<cmd>BookmarksGoto<cr>", { desc = "Go to bookmark at current active BookmarkList" })

-- [[ and ]] jumps back and forth over history
vim.api.nvim_set_keymap("n", "[[", ":lua vim.api.nvim_command('normal! <C-o>')<cr>", with_opts "Go backward in history")
vim.api.nvim_set_keymap(
  "n",
  "]]",
  -- lua interprets C-i in a weird way, so the line below remaps it.
  -- thanks, chatGPT
  ":lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-i>', true, false, true), 'n', true)<cr>",
  with_opts "Go forward in history"
)
