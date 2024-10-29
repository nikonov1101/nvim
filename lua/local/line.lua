local M = {}

local function git_branch()
    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
    if string.len(branch) > 0 then
        return branch
    else
        return "[no git]"
    end
end

local function colorize(s, colorn)
    return string.format("%%%d*%s%%*", colorn, s)
end

local function work_dir()
    -- :t truncates the given CWD to a last segment,
    -- which is often used as a project name.
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

-- todo: copy colors definitions from plugins/darkula_theme.lua
-- and keep them in a single place.
--
-- local hi = vim.api.nvim_set_hl
-- hi(0, "User1", { fg = "#eea040" })
--
-- hi User1 guifg=#eea040 guibg=#222222
-- hi User2 guifg=#dd3333 guibg=#222222
-- hi User3 guifg=#ff66ff guibg=#222222
-- hi User4 guifg=#a0ee40 guibg=#222222
-- hi User5 guifg=#eeee40 guibg=#222222
--
-- If the statusline is not updated when you want it (e.g., after setting
-- a variable that's used in an expression), you can force an update by
-- using `:redrawstatus`.
-- // TODO(nikonov): use https://github.com/EdenEast/nightfox.nvim?tab=readme-ov-file#interactive to build better status line.

local function status_line()
    -- local bufferNumber  = "#%n"
    local gitBranch     = git_branch()
    local workdir       = work_dir()
    local fileFullPath  = "%<%f"
    local modifiedFlag  = " %m"
    local readonlyFlag  = " %r"
    local lineInfo      = "%5l/%L%* %p%%"

    local aligner       = "%="
    local leftSeparator = " :: "

    return string.format("%s%s%s%s%s%s%s%s%s%s%s",
        " ",
        colorize(gitBranch, 0),
        leftSeparator,
        colorize(workdir, 0),
        leftSeparator,
        colorize(fileFullPath, 0),
        colorize(modifiedFlag, 0),
        colorize(readonlyFlag, 0),
        aligner,
        colorize(lineInfo, 0),
        " "
    )
end

vim.opt.statusline = status_line()

local function update_status_line()
end

function M.setup()
    update_status_line()
end

return M
