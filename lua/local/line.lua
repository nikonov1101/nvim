local M = {}

local tools = require("tools")

local macro = ""

local function status_line()
    local gitBranch = tools.git_branch()
    local workdir = tools.cwd_basename()
    local fileFullPath = "%<%f"
    local modifiedFlag = " %m"
    local readonlyFlag = " %r"
    local lineInfo = "%5l/%L %p%%"
    local cmdLine = "%S" -- show cmdline content in statusline

    local aligner = "%="
    local leftSeparator = " :: "

    return table.concat({
        "%1* ", -- colorize all with User1
        workdir,
        leftSeparator,
        gitBranch,
        leftSeparator,
        fileFullPath,
        modifiedFlag,
        readonlyFlag,
        aligner,
        " ",
        macro,
        " ",
        cmdLine,
        lineInfo,
        " ",
    }, "")
end

function M.setup()
    local group = vim.api.nvim_create_augroup("status-line-hooks", {})
    vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
        group = group,
        callback = function(ctx)
            if ctx.event == "RecordingEnter" then macro = "recording @" .. vim.fn.reg_recording() end
            if ctx.event == "RecordingLeave" then macro = "@" .. vim.fn.reg_recording() end

            -- redraw status line with updated macros status
            vim.opt.statusline = status_line()
        end,
    })

    -- move status line from separate line to a statusline
    -- (%S in the status_line() function)
    vim.opt.cmdheight = 0
    vim.opt.showcmdloc = "statusline"
    vim.opt.statusline = status_line()
end

return M
