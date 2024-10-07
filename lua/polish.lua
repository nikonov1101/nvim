-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- show references with Telescope, much better to see the context
vim.lsp.handlers["textDocument/references"] = function(_, _, _) require("telescope.builtin").lsp_references() end

-- tune up parameters to Go LSP
require("lspconfig").gopls.setup {
  single_file_support = true,
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = false,
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}

-- custom keymaps
local opts = { noremap = true, silent = true }
-- search everything
vim.api.nvim_set_keymap("n", "<C-o>", ":Telescope find_files<cr>", opts)
vim.api.nvim_set_keymap("n", "<C-f>", ":Telescope current_buffer_fuzzy_find<cr>", opts)
vim.api.nvim_set_keymap("n", "<C-_>", ":Telescope live_grep<cr>", opts)
-- duplicate as C-/ because C-_ seems broken on macOS
vim.api.nvim_set_keymap("n", "<C-/>", ":Telescope live_grep<cr>", opts)

-- go to implementation
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
-- return back Rename to LSP menu
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
-- make Ctrl+K works in both insert and normal modes
-- same hotkey for insert mode: see `toggle_key` @ ./plugins/lsp_signature.lua
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

-- << and >> navigate buffers, works much better than [-b for me
vim.api.nvim_set_keymap("n", "<<", ":bp<cr>", opts)
vim.api.nvim_set_keymap("n", ">>", ":bn<cr>", opts)

vim.keymap.set({ "n", "v" }, "mm", "<cmd>BookmarksMark<cr>", { desc = "Mark current line into active BookmarkList." })
vim.keymap.set({ "n", "v" }, "mo", "<cmd>BookmarksGoto<cr>", { desc = "Go to bookmark at current active BookmarkList" })

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
