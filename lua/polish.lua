-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.scrolloff = 10
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

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

-- move visually selected lines with J and K, thanks ThePrimeagen
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- jump half-page up/down centers the cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- also center the search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- << and >> navigate buffers, works much better than [-b for me
vim.keymap.set("n", "<<", ":bp<cr>", with_opts "To to left buffer")
vim.keymap.set("n", ">>", ":bn<cr>", with_opts "To to right buffer")
-- change into a blackhole register
vim.keymap.set("n", "C", '"_ciw', with_opts())
vim.keymap.set("n", 'c"', '"_ci"', with_opts())
vim.keymap.set("n", "c(", '"_ci(', with_opts())
vim.keymap.set("n", "c)", '"_ci)', with_opts())
vim.keymap.set("n", "c{", '"_ci{', with_opts())
vim.keymap.set("n", "c}", '"_ci}', with_opts())
-- delete into a the blackhole register
vim.keymap.set("n", "X", "dd", with_opts())
vim.keymap.set("n", "dd", '"_dd', with_opts())
vim.keymap.set("n", "D", '"_diw', with_opts())
vim.keymap.set("n", "x", '"_x', with_opts())

vim.keymap.set("n", "<leader>rr", ":!go run %<cr>", with_opts "go run this file")
vim.keymap.set("n", "<leader>rt", ":TestNearest<cr>", with_opts "go test nearest test")

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
