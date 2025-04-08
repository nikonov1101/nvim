vim.opt.cursorline = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
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
vim.opt.mouse = ""
vim.opt.completeopt = "menu,preview,fuzzy"
vim.opt.shortmess = "ltToOCFsc"

-- Searching
vim.opt.incsearch = true -- search as characters are entered
vim.opt.hlsearch = false -- do not highlight matches
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true -- but make it case sensitive if an uppercase is entered

vim.opt.termguicolors = true -- enabl 24-bit RGB color in the TUI

vim.g.netrw_browse_split = 4
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 20
vim.g.netrw_liststyle = 3
vim.g.netrw_altv = 1

-- set window title to a current directory (aka project) name
vim.opt.title = true
vim.opt.titlestring = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

-- share single status live for each split
vim.opt.laststatus = 3
-- statusline to show buffer number before the file name
-- statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

vim.opt.showmode = false -- we are experienced, wo don't need the '-- INSERT --' mode hint
vim.opt.splitbelow = true -- open new vertical split bottom
vim.opt.splitright = true -- open new horizontal splits right

vim.opt.confirm = true -- confirm write instead of error
vim.opt.visualbell = false -- no visual bell
vim.opt.errorbells = false
vim.opt.synmaxcol = 300 -- Text after this column is not highlighted
