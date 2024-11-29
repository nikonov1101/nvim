local M = {}

local tools = require("tools")

local function lsp_diag()
    local errors = 0
    local warnings = 0
    local infos = 0
    local hints = 0

    local dia = vim.diagnostic.get(0, {})
    for k, v in pairs(dia) do
        local sev = v["severity"]
        if sev == vim.diagnostic.severity.ERROR then
            errors = errors + 1
        elseif sev == vim.diagnostic.severity.WARN then
            warnings = warnings + 1
        elseif sev == vim.diagnostic.severity.INFO then
            infos = infos + 1
        elseif sev == vim.diagnostic.severity.HINT then
            hints = hints + 1
        end
    end

    local ret = {}

    -- TODO: should I colorize it?
    if errors > 0 then table.insert(ret, "E:" .. errors) end
    if warnings > 0 then table.insert(ret, "W:" .. warnings) end
    if infos > 0 then table.insert(ret, "I:" .. infos) end
    if hints > 0 then table.insert(ret, "H:" .. hints) end

    return table.concat(ret, " ")
end

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
        lsp_diag(),
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
    vim.api.nvim_create_autocmd("DiagnosticChanged", {
        group = group,
        callback = function() vim.opt.statusline = status_line() end,
    })

    -- move status line from separate line to a statusline
    -- (%S in the status_line() function)
    vim.opt.cmdheight = 0
    vim.opt.showcmdloc = "statusline"
    vim.opt.statusline = status_line()
end

return M
