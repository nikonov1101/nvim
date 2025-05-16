vim.opt_local.textwidth = 72
vim.opt_local.colorcolumn = "+0"

vim.opt_local.spell = true
vim.opt_local.spelllang = "en"
vim.opt_local.spellcapcheck = ""
vim.opt_local.spelloptions = "camel,noplainbuffer"

-- sign the current buffer
vim.keymap.set("n", "<leader>n", "<cmd>%!gpg --quiet --clearsign<cr>")

-- persist @f to format message body
-- with proper outline at +72.
vim.fn.setreg("f", "ggVGgq")
