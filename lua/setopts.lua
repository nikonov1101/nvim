vim.opt.cursorline = true
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
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true
-- vim.opt.guicursor = ""

vim.g.netrw_browse_split = 4
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 20
vim.g.netrw_liststyle = 3
vim.g.netrw_altv = 1

-- trying to use built-in folding
vim.opt.foldmethod = "marker"
-- :h vim.treesitter.foldexpr()
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- ref: https://github.com/neovim/neovim/pull/20750
vim.opt.foldtext = ""
vim.opt.fillchars:append("fold: ")
-- Open all folds by default, zm is not available
vim.opt.foldlevelstart = 99
