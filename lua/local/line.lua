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

    if next(ret) == nil then return nil end
    return table.concat(ret, " ")
end

local function git_diff_lines() return vim.b.gitsigns_status end

local macro = ""

local function file_flags()
    local buf = vim.api.nvim_win_get_buf(0)
    local ret = {}

    if vim.bo[buf].readonly then table.insert(ret, "[RO]") end
    if vim.bo[buf].modified then table.insert(ret, "[+]") end

    if next(ret) == nil then return nil end
    return table.concat(ret, " ")
end

local function render(items)
    local ret = {}
    for k, v in pairs(items) do
        if v ~= nil then table.insert(ret, v) end
    end

    return table.concat(ret, " ")
end

local function status_line()
    local fileFullPath = "%<%f"
    local lineInfo = "%5l/%L %p%%"
    local cmdLine = "%S" -- show cmdline content in statusline

    local aligner = "%="
    local leftSeparator = "::"

    return render({
        "%1*", -- colorize all with User1
        fileFullPath,
        "", -- a little more gap
        file_flags(),
        lsp_diag(),
        git_diff_lines(),
        aligner,
        " ",
        macro,
        " ",
        cmdLine,
        lineInfo,
        "",
    })
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
    vim.api.nvim_create_autocmd(
        { "DiagnosticChanged", "LspAttach", "TextChanged", "InsertLeave", "BufWritePost", "BufEnter" },
        {
            group = group,
            callback = function() vim.opt.statusline = status_line() end,
        }
    )

    -- move status line from separate line to a statusline
    -- (%S in the status_line() function)
    vim.opt.cmdheight = 0
    vim.opt.showcmdloc = "statusline"
    vim.opt.statusline = status_line()
end

return M
