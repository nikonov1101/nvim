vim.opt_local.textwidth = 72
vim.opt_local.colorcolumn = "+0"

-- persist @f to format message body
-- with proper outline at +72.
vim.fn.setreg("f", "ggVGgq")
